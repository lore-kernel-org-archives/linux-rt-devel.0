Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E5318EC5;
	Fri, 10 Apr 2026 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792449; cv=none; b=haHBw9dnLe3tlZdZo5IRfY7++EkngK+5huNmKdPJu9dWtSgEGInjGIMpTLtaNEYnfBmk9fB3HNy3Ncus14soMKA0WxzWEi6KcX076u6yRQkSaxZr2srYXa+EXeQmANfGoHBB55E9HpJhe4k0Os3Ws2bFlxY1invqGTiB491klhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792449; c=relaxed/simple;
	bh=4fFvtQ3Y5pCUDYpa/z0iP+svCl1RFHypsVdS/F6UH0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CkA4rLfm4WpcwJMh/lVNW0IrCfC75YGltVO6QCktq1SrMGVJUKyvwdDygCI1PDC877eyEgqF/IXmIN47NaFDn04WEBPP7xK65l+5ftjNFvou2KbUT1tFKuCdXvVOMiYIP24NLlpNXg7z99I8ZVM+V6t98+9jo4xQ7bMgBewqOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI39JkEu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI39JkEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B27DC19424;
	Fri, 10 Apr 2026 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792449;
	bh=4fFvtQ3Y5pCUDYpa/z0iP+svCl1RFHypsVdS/F6UH0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jI39JkEuEm4ZfnDeVx8GtRgNk9PdGTtDjw4PsvpylqryuFbmeO4EMIzGSR6L7vvCO
	 e8sxZtScUX174IQv0XD2D7XGgjm/L/sk8H6kuPamOTMz/O5xWtS6KvEKhNfi24vwys
	 t0F/lShPrBpe7ZREcMwMEU9DL7/ZK7vei1qND+uMT0V13zbH3owkugF4YhIQP5rrOj
	 J46Cq3Wa+caSwDjr4wWZQIkyB+d7/YmLdzycUO3M7vkUKOlf/BNgvrJM1y86aHAZ1H
	 pfcCpoEm1mRGnrMpom2Dbl1O/4aLgnrvbFdb3/mdYtImNoxwN0WOHm++jr0VzgVTN3
	 NY+PyxfK2Ay3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DE83809A22;
	Fri, 10 Apr 2026 03:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: macb: Use napi_schedule_irqoff() in IRQ
 handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579242429.1854480.11368956637200053127.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:24 +0000
References: <20260407-macb-napi-irqoff-v1-1-61bec60047d7@gmail.com>
In-Reply-To: <20260407-macb-napi-irqoff-v1-1-61bec60047d7@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 07 Apr 2026 08:45:39 +0800 you wrote:
> For non-PREEMPT_RT kernels, the IRQ handler runs with interrupts
> disabled, allowing the use of napi_schedule_irqoff() to save a pair of
> local_irq_{save,restore} operations. For PREEMPT_RT kernels,
> napi_schedule_irqoff() behaves identically to napi_schedule().
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: macb: Use napi_schedule_irqoff() in IRQ handler
    https://git.kernel.org/netdev/net-next/c/a17d3c3d0cb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


