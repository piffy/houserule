module UsersHelper

    #Returns the Gravatar (http://gravatar.com/) for the given user Defaults to identicon.
    def gravatar_for(user, size=80)
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?&d=identicon&s=#{size}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end

end
