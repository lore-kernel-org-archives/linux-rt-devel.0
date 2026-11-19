Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053011;
	b=p59nMwZx+zU0/0q5k2M143N3QUYAKXlnrGfrylWBVzXXuKy01wpjoYBQDvksDwiOGHZU
	 3mxzgY6FnagW2yZtR91gVHbBlAIFIrkcpb2DEErhr66fQ0kdNN3JAXG6rO2JwgHjajQ3v
	 OcLTlDt6vw0WJNJcJl3owOPJRhf5B4WkKKfJeFZoNBAh/SCpwlpttYs4hPeaUlSml34Tj
	 XSgCXkY9ONUIbll8dGi51iXioCR00ClaSvTlaNmLKphWICMP0u7mPqEhHsoTIV2h41yeK
	 cACbkeDo+MDHvg/aqRJhH4iHzunkI7O9y0vEXkgCqcJKa/ooXQJIbTWgtio/NJsxg9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ttrxSxpE+Q+mpNUeMr0sCUPblz0LLvYtA2JvNlvZ3ns=;
	b=tXr0fnpnzseXnBIK0RA5bfEsWz91uYamP43xKJfwgaaAk/Gwt5+ZP4ZVjsIfLn2YU7Rd
	 xgSfdFleWjQSdItZMgAfc38fgaZ1aXL8UB9y6BH2fNsEHVh3/c8Zz/2vL88bWvMi+LWF/
	 esYZEtw2bSPI6NrAsG1NdWraYI2oNu8F8YPGX+EqNsfG7HT7V9pjjKRYlO/N17xkJdq0Q
	 bw2zMvdd4KxDLTo/eGVqtTZy5pZcqUiEkYJpEmYcl7kuLwaroM6a83HCv52BZo5POZ0hc
	 ZMQtN7AKxQzUP7S7SEUKvGpOzwUUtvZajQ6LZcVLjVibvpw6/u4T+P341JLiDKu2odQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLjN5IPp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D3606A31C;
	Thu, 19 Nov 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLjN5IPp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067741F000C4;
	Thu, 19 Nov 2026 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053011;
	bh=ttrxSxpE+Q+mpNUeMr0sCUPblz0LLvYtA2JvNlvZ3ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WLjN5IPpDCrxQsA0lADOoPKtuoD+yqw6nAlLrI7zfJJax9KpGCaVE7QHtZb40arx/
	 IWwzT4THXI2HHdKH8uP3IgmDx+EgaQyzYs33F1vdxZySvncoqWUUC2WZnGm4UFLvfv
	 RrULg/vobKoajiTHv164J0eoa3Qy6tUbZsPWRkV/PvmuOenA4ZRx4U07BBe5hfdIGd
	 msSpHM+WE3PKZx5rvrd2rC3vpOHhQXH8dWhm0EiIQqy3ystOuNO+Dvumuyj/5TLlYN
	 2EpRSvAaYm0WHgEoMkwqPDoYrtXywPWD9c9lnMVOKrjx9M0T+K5M+j9viJsXJGsxZg
	 ClTMe93dm7Omg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15D03808210;
	Thu, 19 Nov 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v7 0/6] amt: relay tunnel lifetime,
 validation and request-path hardening
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179505300952.2710764.11211154682646312778.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 01:50:09 +0000
References: <20261110210538.217936-1-omar@blockcast.net>
In-Reply-To: <20261110210538.217936-1-omar@blockcast.net>
To: Omar Ramadan <omar@blockcast.net>
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, kuniyu@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 21:05:31 +0000 you wrote:
> This series hardens AMT relay tunnel lifetime, validates gateway input, and
> keeps unauthenticated Requests from consuming relay state. The problems
> fixed by patches 3 and 4, and the pre-Query drop in patch 5, were found
> during the AMT IPv6 outer transport work, which is not included here.
> 
> I am using the existing IPv4 AMT relay and gateway implementation in a
> multicast delivery network, where gateways on access networks send IGMP/MLD
> membership state through a relay to reach downstream receivers.
> 
> [...]

Here is the summary with links:
  - [net,v7,1/6] amt: stop receiving before amt_dev_stop() tears down its state
    https://git.kernel.org/netdev/net/c/cd057fd9c742
  - [net,v7,2/6] amt: fix use-after-free when a Membership Update re-arms a freed tunnel
    https://git.kernel.org/netdev/net/c/5931fd2440de
  - [net,v7,3/6] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
    https://git.kernel.org/netdev/net/c/b4fa7f8daed6
  - [net,v7,4/6] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
    https://git.kernel.org/netdev/net/c/144183ab4b05
  - [net,v7,5/6] amt: make pre-query report drops visible
    https://git.kernel.org/netdev/net/c/ee58008edb99
  - [net,v7,6/6] amt: create relay tunnels only from authenticated Updates
    https://git.kernel.org/netdev/net/c/8ddd3a1c207f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


