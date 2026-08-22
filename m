Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCF3803C7;
	Sat, 22 Aug 2026 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430676; cv=none; b=gqhtDPgYRQjnu4NXoUC5t44W7+Uj58tbsChRhjXiNXpjQE8EnjPMj6T9St10fiNHathTxhGYW9Mfeu08Zc3+9H5MtL/9gVmYQjCEdHsrj9+VMIJ5Soio1HYlq/fVAsdrlXRoXonWncf2MDPxWTkzyScJl7nhfhCupV7HKeY4vNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430676; c=relaxed/simple;
	bh=bb829ReP77fPpPXBQ1aBSHRNqKouFLWIe4d842j6OF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sPQkA0z3RMvIEogCMFYBi12X0FnQkSQJrmgI8JJpDRQktV0iV93vlCxYCfIh0dkkzY54pF0s2bifsyk8IIB+AnVXq3hr8Gi763dTCUYabPBiNGxyUCy0z+5oQ4mwSYnXEgNjeyWI0PBtllCugvmxBln+MR8Rc5klZGPsNgKq90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbYsD1B2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbYsD1B2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A371F00A3A;
	Sat, 22 Aug 2026 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430674;
	bh=U2WhrpQyzjfizAD7WjiNO5bi7n4CM21BaILhRpMuMmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IbYsD1B28Snl7Pxro13woCr2Do96Ncq0OUQywwKJzr1KILoT/m8w97s7skvNKOjfO
	 26YIopy3u/XpRFBIrSm75kUkMR0/A6UXITmr9WyGMckXKSc9Gnf1mrGoIFSeiEdvVA
	 RMs3vBsnGncnSL8pWlDq8i9xGjokh3JI3MecdcbaD97DVgrtjVap1DKWZRz7Zwg2GZ
	 CiCqFVg85/03tY03e6/kowwkV7SvcyLbvjdHg/pGc5xC2ZniVkoG82hTiY8aBXlh/o
	 hLay/oQNQhdQzp/dhXB9rerFUpZgpWQijxLvknvzjK90ws1vfJ9Kt7+d+oum6yq+J8
	 zAIRZDnhJpdIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB5380CEF9;
	Sat, 22 Aug 2026 20:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: sparx5: misc fixes for sparx5 and lan969x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743062338.1819488.10941044627288151617.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:30:23 +0000
References: 
 <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
In-Reply-To: 
 <20260817-misc-fixes-sparx5-lan969x-v3-0-c7c7fef723a8@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, bjarni.jonasson@microchip.com,
 lars.povlsen@microchip.com, p.zabel@pengutronix.de, kees@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, steen.hegelund@microchip.com,
 linux-rt-devel@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 17:41:57 +0200 you wrote:
> This series fixes various issues in the sparx5 driver, which also
> serves lan969x.
> 
> Details are in the individual commit descriptions.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: microchip: vcap: use port number instead of netdev name for debugfs
    https://git.kernel.org/netdev/net/c/b7adcc56fd3d
  - [net,v3,2/2] net: sparx5: fix sleep in atomic context in MAC table access
    https://git.kernel.org/netdev/net/c/b62793a7baee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


