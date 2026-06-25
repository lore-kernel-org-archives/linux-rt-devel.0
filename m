Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA63A8757;
	Thu, 25 Jun 2026 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353429; cv=none; b=Ih+zySJZGn5PKXgGaDpoZP1EuZPgYq4zqEEIVkj2/bdEFl7VHTMpx6qagmMeB9BHkb3Dr0SmwdzDP81sHa/b0AEasWnO4w1Tbf5H0jsjUqAAjDGCKAN7D6i+XWW1Xww/3M+cKDMD314TpW8zlcgIJItFXhrw63qrcKwla244YWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353429; c=relaxed/simple;
	bh=NGQeKDnfgCrXu/1cMppN+cdKDM1jC2DCXUnSIWGLp3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I0yksGdG/B/EnNNUraHJX7QZUtM5pxbLFXopOX40GuWe84oBq4vUW+GsYotHA1bnIsjZhZvM2U2ByXFHGN3FljoI46d460xzpzpjby4rsdeoW7cvzEQlAKDfeRINQ9p439VmQzyA8/lTmHwBP50fJMXhzGEJWDE8dXQPX0Y7FkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgJgHXNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgJgHXNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBBF1F000E9;
	Thu, 25 Jun 2026 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782353428;
	bh=uQ86/oRM7sU4wIrh/FJZ/Eb6hahhyaUF9V2kasWDLfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IgJgHXNGcYobqHw0eVpsTZzbvUU4ADZdBBy4AdAxASM0u6COr+UgYM77/kzwlZtjD
	 LwRRCRdS6k8p163T0YrBHspra1Eko4mHl7cr6rsmn4o1ZQ7xJ1+XqbZCuRHg1ke4Mb
	 3RuETEwwCXK2NoKMa8qflgHI3ulkz1lJ9iMVvY/j5aqT5zoQvbqHU4J3smMx/GbOiE
	 lW8T+R0Mb2vVUdY10qpuPPFQOxyNNidcQ2yw2L73JjtlL5WeQfJVe2E1NJra6p9ZBG
	 jxb+zUdLxKdWi0Z+7YxPhYBnBdYIZQLQjdCHr4K5iGETmYwVlu1SLKRD4m58NDmpuL
	 +LYUjCli82RNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ABA3AAA6D4;
	Thu, 25 Jun 2026 02:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: mvneta: re-enable percpu interrupt on resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235341652.3082498.6358725051610913583.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:10:16 +0000
References: <20260622074350.1666290-1-yun.zhou@windriver.com>
In-Reply-To: <20260622074350.1666290-1-yun.zhou@windriver.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 15:43:50 +0800 you wrote:
> On Marvell MPIC platforms (Armada 370/XP/38x), mvneta uses a percpu
> IRQ disable/enable scheme for NAPI: the ISR (mvneta_percpu_isr) calls
> disable_percpu_irq() to mask the MPIC per-CPU interrupt and schedules
> NAPI poll, which calls enable_percpu_irq() on completion to unmask.
> 
> If suspend occurs while NAPI poll is pending (between
> disable_percpu_irq in the ISR and enable_percpu_irq in poll
> completion), the interrupt is never re-enabled:
> 
> [...]

Here is the summary with links:
  - [v4] net: mvneta: re-enable percpu interrupt on resume
    https://git.kernel.org/netdev/net/c/fd398d648098

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


