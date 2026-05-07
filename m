Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70559284B4F;
	Thu,  7 May 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170858; cv=none; b=fG9qjvsj7vS/aqeMRdjhYOWcMnhOTrNs3JGGSSQ2V79EAyaGANL8XLauBRbH9moOBOrqlzaZIudem8qNqTmOQlP0AbpSGIuHsAtD+AemWLXwk9o4dAOi8ON9GljxXTRF6izHXwpou6ZDCEQacgsn8g2A3NQHHRrah0ALJiDxqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170858; c=relaxed/simple;
	bh=urDw1WgtuawgHybQYaJY9BK5m5+/xhvBD524RXgulv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ar+zKJj2mR0kKHtDX0YZQhI5yrd8qgkT2uR0vAKVP4kGagp007i54IVOt6/SZIvE/7oOnx4tu9ZbFKhlaMjYDTpKM4B3Cw5zeqseCr1ugBTIq+si0kRu0omZbYcirvJ1GC/80zE4+Vu4PS38w3oIvvuPGt2Cj38y8Rlz/6hV458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc/oZkr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc/oZkr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1870EC2BCB2;
	Thu,  7 May 2026 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170858;
	bh=urDw1WgtuawgHybQYaJY9BK5m5+/xhvBD524RXgulv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lc/oZkr1J3RO7L9WW+piFQVUzmBZLF0kAGruYarVuSGl73lhSYPulgQ/sfC7wtoEl
	 M0naWeCAuDbwxLvPsAcuEDBH2hMPEWGXa3I3oyL82dM0hCETxmj2+xRZHIwIIrcJsu
	 L90ddb3Nn9UAL60bftHBcGgIQZTVhMajYlwbnn9nE7NSLMlcWYcC1yb2vrd69gqe0q
	 JjXxG9xmumoOI9K99+ElPKz/ZqdgxzWh2bOm6ijRuq0PJJ3H+ITn/UhOpVRXEUmz03
	 HEBGs41iaVlauZ3LL+/eYMxW9WTg445KJWBDRiLMgRdYG0XOxQRVtABkXXxbi0mrpB
	 biIvnpeoL15mQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE043930909;
	Thu,  7 May 2026 16:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] net: sparx5: misc fixes for sparx5 and lan969x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177817080728.4064915.505121017219538235.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 16:20:07 +0000
References: 
 <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
In-Reply-To: 
 <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, bjarni.jonasson@microchip.com,
 lars.povlsen@microchip.com, p.zabel@pengutronix.de, kees@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, steen.hegelund@microchip.com,
 linux-rt-devel@lists.linux.dev, andrew@lunn.ch

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 May 2026 09:25:35 +0200 you wrote:
> This series fixes various issues in the sparx5 driver, which also
> serves lan969x.
> 
> Details are in the individual commit descriptions.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] net: sparx5: defer VCAP debugfs creation until after netdev registration
    (no matching commit)
  - [net,v2,2/4] net: sparx5: fix sleep in atomic context in MAC table access
    (no matching commit)
  - [net,v2,3/4] net: sparx5: fix wrong chip ids for TSN SKUs
    https://git.kernel.org/netdev/net/c/b131dc93f7bf
  - [net,v2,4/4] net: sparx5: configure serdes for 1000BASE-X in sparx5_port_init()
    https://git.kernel.org/netdev/net/c/41ae14071cd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


