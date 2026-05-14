Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3631F998;
	Thu, 14 May 2026 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723473; cv=none; b=QYkqtmgYhD3AtGKMCheGxtpoxKRzjWUVffoKVsCFozhF5DO2Xenq0tjSVWDbkRSdrd2KY+ZcMewV78EHfRM1uRQb5w7O7FGyB8z2KA8Qb7tiGas+TGOjqKV7yDAq5QvYGWDpaII05Z3ci9isFfSdppDCSfUdh3Fp3xrrwknKBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723473; c=relaxed/simple;
	bh=3H8szPJuTfoSbwop1vb9V7PNpOPK/p03rZv+q3yuneE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PWBcwAi5WW1s7XzQY+300qQGPlTx9wJ16F9t72du6vhiAaFZXV9Ix/ebPzsb2TNXPZuJ+QVisW5txGdx5RbzV/+Evp9DRdlM1n1kC3I+rg49KVF7VVqxPhhIuGBr9zOankip4zJXna5kR1JZFHrp1RJP5hjcDyjgdUtwIGNENKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvbCOAz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvbCOAz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D89C2BCB8;
	Thu, 14 May 2026 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723473;
	bh=3H8szPJuTfoSbwop1vb9V7PNpOPK/p03rZv+q3yuneE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mvbCOAz3XJZv0Llqpk7hHMiw6gppdE/JlWN0SwvT1UAoiqGrHRABcDDYab6S5MxSL
	 oL7xfXgnzl4qBB/jRoHoye8bxBsS4Jrr0RTrz8xtKNZnDoSkpYr6Qlr0EWXQNbEQ4j
	 raI/Fwl+OOfJhEBGX/XeNAL2U/NVUtqNvE6SfvkT06I7xjB8YlQDRRpsMeJu+lvzJg
	 R+k1BOX95kvDq+GbkfVIo/o032+3bwxoKkT6FxfFuap9/iPueg1BJCJZJwHdJLiFUp
	 RajHkdlea+hpYf8M4yLeoP4yQe8LfhxLJ661LoVCLuXMbUwoiIBGAMs0nxLmwjUub5
	 vXv7RqgnvZmAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEE3382330A;
	Thu, 14 May 2026 01:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] netpoll: move out netconsole-specific
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872341822.3917291.11068768935425222711.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 01:50:18 +0000
References: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
In-Reply-To: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 03:46:33 -0700 you wrote:
> netpoll and netconsole were created together and their code has
> been intermixed in net/core/netpoll.c for decades. The result is
> that netpoll exposes two send-side interfaces:
> 
>  * a generic "give me an sk_buff" path used by every stacked-device
>    driver (bonding, team, vlan, bridge, macvlan, dsa),
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] netpoll: expose UDP packet builder helpers for netconsole
    https://git.kernel.org/netdev/net-next/c/06baf87e219f
  - [net-next,v2,2/9] netconsole: move netpoll_send_udp() from netpoll
    https://git.kernel.org/netdev/net-next/c/d3345a61e4ae
  - [net-next,v2,3/9] netconsole: move push_ipv6() from netpoll
    https://git.kernel.org/netdev/net-next/c/c411baa463e8
  - [net-next,v2,4/9] netconsole: move push_ipv4() from netpoll
    https://git.kernel.org/netdev/net-next/c/5664c3908b70
  - [net-next,v2,5/9] netconsole: move push_eth() from netpoll
    https://git.kernel.org/netdev/net-next/c/6a44c82a48c7
  - [net-next,v2,6/9] netconsole: move push_udp() from netpoll
    https://git.kernel.org/netdev/net-next/c/df82899714b1
  - [net-next,v2,7/9] netconsole: move netpoll_udp_checksum() from netpoll
    https://git.kernel.org/netdev/net-next/c/597bfa943131
  - [net-next,v2,8/9] netpoll: rename and export netpoll_zap_completion_queue()
    https://git.kernel.org/netdev/net-next/c/7bb1daff3612
  - [net-next,v2,9/9] netconsole: move find_skb() from netpoll
    https://git.kernel.org/netdev/net-next/c/f35422ed3664

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


