#!/usr/bin/env fish
# apt lags releases, thus the script.

function install_helix_latest
    echo "🔍 Fetching latest Helix release..."

    # Get latest release info from GitHub API
    set latest_release (curl -s https://api.github.com/repos/helix-editor/helix/releases/latest)

    if test $status -ne 0
        echo "❌ Failed to fetch release information"
        return 1
    end

    # Extract tag name and download URL for the .deb file
    set tag_name (echo $latest_release | jq -r '.tag_name')
    set deb_url (echo $latest_release | jq -r '.assets[] | select(.name | endswith("_amd64.deb")) | .browser_download_url')

    if test -z "$tag_name" -o "$tag_name" = null
        echo "❌ Could not parse release tag"
        return 1
    end

    if test -z "$deb_url" -o "$deb_url" = null
        echo "❌ Could not find .deb download URL"
        return 1
    end

    echo "📦 Latest version: $tag_name"
    echo "🔗 Download URL: $deb_url"

    # Create temp file
    set temp_deb (mktemp --suffix=.deb)

    # Download the .deb file
    echo "⬇️  Downloading..."
    curl -L -o $temp_deb $deb_url

    if test $status -ne 0
        echo "❌ Download failed"
        rm -f $temp_deb
        return 1
    end

    echo "✅ Downloaded successfully"

    # Install the package
    echo "📦 Installing Helix $tag_name..."
    sudo dpkg -i $temp_deb

    if test $status -ne 0
        echo "⚠️  Installation had issues, attempting to fix dependencies..."
        sudo apt-get install -f

        if test $status -ne 0
            echo "❌ Failed to fix dependencies"
            rm -f $temp_deb
            return 1
        end
    end

    # Clean up
    rm -f $temp_deb

    echo "🎉 Helix $tag_name installed successfully!"
    echo "🚀 Run 'hx' to start using Helix"
end

# Check if jq is installed
if not command -q jq
    echo "❌ jq is required but not installed. Install it with: sudo apt install jq"
    exit 1
end

# Check if curl is installed
if not command -q curl
    echo "❌ curl is required but not installed. Install it with: sudo apt install curl"
    exit 1
end

# Run the installation
install_helix_latest
