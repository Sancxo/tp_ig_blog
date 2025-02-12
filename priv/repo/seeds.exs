# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     IgBlog.Repo.insert!(%IgBlog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias IgBlog.News
alias IgBlog.Accounts
alias IgBlog.Accounts.User

{:ok, %User{id: admin_id}} =
  %{fullname: "Admin McAdmin", password: "password", is_admin: true} |> Accounts.create_user()

Accounts.create_user(%{fullname: "Simple Userson", password: "password", is_admin: false})

[
  %{
    title: "Hello, World !",
    body:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam tincidunt ac erat commodo suscipit. Sed eleifend, ipsum a viverra eleifend, magna nisl fringilla turpis, ut dictum nunc urna in sem. Nam vitae viverra turpis. Maecenas pulvinar dapibus lacus quis vehicula. Proin vehicula est dui, eget pellentesque neque rutrum sit amet. Sed tristique, nisl vel pretium tempus, ipsum lectus tristique libero, ut rhoncus purus nibh ornare lectus. Morbi sed lectus sed metus mollis porttitor. In ullamcorper, arcu aliquam consectetur fringilla, massa est semper erat, a semper mi ante a sem. Aliquam sagittis justo non tortor hendrerit consectetur commodo vitae sem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed eros ligula, mattis in massa ac, porta rutrum lectus.
      Integer eget lorem erat. Vestibulum interdum scelerisque rhoncus. Sed dignissim odio quis quam dignissim ornare. Nam maximus molestie leo ut rhoncus. Proin ornare eu nunc sed rhoncus. Pellentesque aliquet ultricies arcu, vel vestibulum odio vehicula vitae. Sed facilisis vestibulum lectus ut sodales. Aliquam erat volutpat. Vivamus ultricies eros quis nisi suscipit rutrum.
      Morbi eget vehicula dui. Cras lectus nulla, lobortis et vestibulum et, convallis nec eros. Mauris placerat augue elementum enim ultricies vestibulum. Phasellus luctus augue quis quam volutpat facilisis. In egestas condimentum leo, non maximus neque. Integer posuere pretium nunc, sed fermentum nunc efficitur ac. Praesent tempus porta lacinia. In varius velit et efficitur condimentum. Integer rutrum vel mi pellentesque vulputate. Ut viverra eros vitae vestibulum hendrerit.
      Vestibulum congue orci eget mauris gravida, nec iaculis lacus scelerisque. Vestibulum pellentesque risus vitae nisi bibendum consequat. Cras feugiat at neque sit amet ornare. Proin vel lacus vulputate, volutpat arcu quis, ultricies justo. Sed libero neque, interdum nec congue convallis, commodo in sem. Pellentesque vulputate lacus convallis, semper metus sed, interdum metus. Curabitur eu tortor diam. Sed aliquam nisl vitae nisl fermentum porta.
      Integer eu commodo ex. Proin sit amet hendrerit mi, nec euismod diam. Suspendisse rutrum lobortis eros cursus fermentum. Nullam malesuada lorem at dui eleifend tincidunt. Suspendisse vel tellus in dolor sodales consectetur vel efficitur sapien. Duis tristique, nunc ac malesuada eleifend, justo sem sodales turpis, non hendrerit mi justo ut elit. Nunc dictum libero felis, id auctor leo luctus vitae. In imperdiet tristique porttitor. ",
    slug: "hello-world",
    status: "published",
    published_at: ~N[2025-01-29 12:00:00],
    author_id: admin_id
  },
  %{
    title: "First post",
    body:
      "Cras laoreet eros porta felis consectetur fermentum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed pellentesque dignissim laoreet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec non fermentum nunc, eu luctus justo. Sed fermentum neque pellentesque felis blandit pretium. Etiam blandit tincidunt eros.
      Pellentesque ut condimentum dui. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus hendrerit nisl ultricies nisi posuere, in varius lectus molestie. Curabitur vitae ante turpis. In diam quam, hendrerit sed tristique vitae, laoreet vitae sem. Quisque non vehicula lectus. Vestibulum ante magna, consectetur id sodales quis, vestibulum eget ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nunc sed libero at arcu consequat ornare in id risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas accumsan dolor sit amet efficitur porta. Suspendisse dapibus leo congue lorem congue, eu condimentum est volutpat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Fusce sed nisl vel lorem gravida consequat non nec purus. Duis eget dui lorem.
      Sed congue vulputate tincidunt. Sed aliquam, nunc vel ultricies efficitur, odio lacus ultrices ex, quis suscipit odio tortor luctus eros. Fusce maximus augue id nisl vehicula, fermentum pellentesque sapien placerat. Sed tristique fermentum ligula. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed euismod mattis diam id auctor. Suspendisse feugiat nunc eget pharetra rhoncus. Maecenas quis lectus odio. Nunc id ipsum sed quam elementum faucibus. Nulla vel congue lectus. Phasellus id varius nulla. Donec hendrerit, risus eget dapibus egestas, ex augue euismod orci, non blandit quam ex id nibh. Nam sed eleifend ipsum. Pellentesque vehicula ante id elementum vehicula.
      Vestibulum vestibulum risus vel ipsum vehicula, mollis elementum nisi tincidunt. Proin eleifend fringilla ligula, in vehicula quam. Duis at vehicula quam. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam eu urna vel nisl convallis congue. Proin sed sapien nec urna pharetra iaculis sit amet nec est. Vestibulum tempor vitae eros ut aliquet. Nunc consequat ligula non felis tempor, quis fermentum ipsum sollicitudin.
      Sed ultricies mauris vel tincidunt ultricies. Morbi tempor libero sed justo malesuada sollicitudin. Sed vitae pretium velit, sit amet semper nulla. In vel condimentum justo. Nullam pretium justo elementum pellentesque volutpat. Proin erat purus, pretium at justo sit amet, pharetra tincidunt odio. Morbi feugiat orci nisl, id sodales ante venenatis nec. Phasellus pharetra sed ipsum ac hendrerit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Etiam vitae est ac nibh elementum dictum sed vestibulum neque. Pellentesque tempus, leo et congue fringilla, felis ante tristique nisl, vitae pellentesque nisi lorem at mi. In condimentum risus in porttitor mollis.
      Morbi lobortis ipsum in sem iaculis accumsan. Duis dolor risus, sollicitudin et est in, blandit molestie tortor. Donec molestie auctor est, a imperdiet sem faucibus in. Proin pretium metus non urna viverra posuere. Donec pretium leo sit amet iaculis lobortis. Integer consequat imperdiet leo a dictum. Vestibulum dapibus enim arcu, eu ultrices nulla congue nec.
      Aenean ornare diam pulvinar ex volutpat suscipit. Curabitur aliquet mi nisi, a mollis mi auctor vel. In non blandit dui. Ut commodo pellentesque egestas. Nullam fringilla fringilla ipsum, ut congue purus facilisis nec. Vestibulum fermentum turpis vitae justo efficitur, sed vehicula sem tincidunt. Vestibulum lobortis ornare scelerisque. Quisque in magna vehicula, aliquam purus in, ornare justo. In eleifend nunc eu nisi fringilla, a iaculis elit pharetra. Nam feugiat nisi ligula, vel tempus felis eleifend dictum. Mauris eleifend risus neque, at euismod neque rhoncus nec.
      Sed molestie nunc ac tortor placerat eleifend. Nunc at mattis sapien, sit amet imperdiet turpis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nullam eu erat lobortis, condimentum urna vel, dignissim tellus. Morbi cursus purus aliquet ullamcorper ullamcorper. Phasellus consectetur ligula a felis aliquam, dignissim dapibus velit euismod. Aliquam a neque egestas, tempor velit eu, accumsan nisl. ",
    slug: "first-post",
    published_at: ~N[2025-01-30 10:00:00],
    status: "published",
    author_id: admin_id
  }
]
|> Enum.each(fn post ->
  News.create_post(post)
end)
