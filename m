Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50B1C5F1B;
	Fri, 20 Mar 2026 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773966614; cv=none; b=KnB1Z140E7O4n+bXCfiXc7z9NckLz3PiSeV9nLJwih+00yOzLcxXZ8JFBxbeBQN6kxCmaCsJEyCQNju+s/QlYwrh/6DzaWunxmQLgEbkgZVa1DZwsKY+i0H2s17DBZnIE3yISsSlnM4Da86T2SXljfxhpemlbRBGJaTOS8Kg9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773966614; c=relaxed/simple;
	bh=kpfpj64bfM+xSIQedze0EmZ0FtannRKTbiQm8gIuVSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y0wKdF+1ZFzO3EBP8QJIarrtndV8u2/n/Eor3Dbm6zgZqp8vRfT2pycZjAO5l03WfDl/P0kAmLRc2e5jenAFwndanpEmdUKh/F1os13V4MkktgvP7e25xn9lsnOnx9ASPGe1MVsHgeJvsf/2XmZ4UvLKF3OiHdclVtM2lS9qtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Ptrf5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Ptrf5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EEAC19424;
	Fri, 20 Mar 2026 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773966614;
	bh=kpfpj64bfM+xSIQedze0EmZ0FtannRKTbiQm8gIuVSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s0Ptrf5WkeD/wMzqs13tYnSFClyFqgs/spOQH6LkOvnkFMGEYQAE5BP9kbBXz4vih
	 Rb6jDmZPgbSseAKXZGICGElwpykscK5+ATGn/HFzEiYmhR7nCdqWeMR0s/GfBzN/xk
	 bMZjh/itZDr9b7vhZ1NPr1olEjFRdC9QUyrCt1hwCeJQ9xNpFwmMXyLy0N8dn4z/f2
	 DxN/BmJ7aEaqf+qn4pmZJ0eL8Nxul+VrcWHaQK64yX+QDU+O+c9xJTUdIuedwglqWq
	 +U8OmHsIbiJLz8z6QEXUiOaBuknY9RQxra6ZZTuXXO4DxWgdy75E4PYoV7Jq9BpTLo
	 Hpcw0UWOq1jOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D0339302F6;
	Fri, 20 Mar 2026 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: Avoid releasing netdev before
 teardown
 completes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396660480.1861152.8680277135332409815.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:30:04 +0000
References: <20260318155554.1133405-1-toke@redhat.com>
In-Reply-To: <20260318155554.1133405-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 pabeni@redhat.com, mhou@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-rt-devel@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 16:55:51 +0100 you wrote:
> The patch cited in the Fixes tag below changed the teardown code for
> OVS ports to no longer unconditionally take the RTNL. After this change,
> the netdev_destroy() callback can proceed immediately to the call_rcu()
> invocation if the IFF_OVS_DATAPATH flag is already cleared on the
> netdev.
> 
> The ovs_netdev_detach_dev() function clears the flag before completing
> the unregistration, and if it gets preempted after clearing the flag (as
> can happen on an -rt kernel), netdev_destroy() can complete and the
> device can be freed before the unregistration completes. This leads to a
> splat like:
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: Avoid releasing netdev before teardown completes
    https://git.kernel.org/netdev/net/c/7c770dadfda5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


