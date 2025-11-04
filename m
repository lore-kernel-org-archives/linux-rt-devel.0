Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238F32ABF7;
	Tue,  4 Nov 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264699; cv=none; b=VB/TTAU0mON/DMkOeMFwkD+rr2580pPvY7Z1PZkGNdeAyq6um9RZBNZaHt2RpDA5V+4w9xGbVCzS3q2HNve/aPy4dKxWhe+zE3xpoVAMjAk2wvTgNteHIBl2WKVdM9cAGYUOIkMsDVAXWjuCdzLjefWHsoFMj4H6hUt3dXt4Hzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264699; c=relaxed/simple;
	bh=4K46elwz2t41thzEDIlkodjmZEybmO5RrzNgtf0xipA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXKJ3KNaSx36TbN5giQa1cBap1fkTRQO+0DbjdX3vanPahP+r6NGa4whaRXCHYtzlApbJx2FyeQYzaVpoaZV+p/fF4I5ELjjVZ9fRf5L0Cn3dy/IMOHT7y2OiDAgGBr1/DeOGAOo2xSffMA1PibyOTczOlaCI50guF/LEY/WAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTuYizHQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTuYizHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1C9C4CEF7;
	Tue,  4 Nov 2025 13:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264698;
	bh=4K46elwz2t41thzEDIlkodjmZEybmO5RrzNgtf0xipA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTuYizHQP/YaIbgF3vqNbGgvB8bHF6TItco2OMyJ9evUpo+GBr20DxE5Jer8+p4K1
	 Q+hFVJhn3gpVicQ2H0Ofyp6uCJN9ymtHFPPLDjxYfofm6lejPtS8XJgwAO5RL0xfrh
	 9nW/y6m3o1sA+lBbGYZwON+Afz1yEkvdQnsCyZWZFCuBjMh861BJOgw4ddIegP8vWw
	 CDy27YlcgnSzhLSu0KN0TojEMMqpNqXy0n7zprfWIzmZl2LTtr0cVzEatQl7Bl8m/u
	 lzMahpVNdy0kWug9HG1JgJqN1YX431c9LR57rP8r6A6CK5d+uRJpVZCbr+WC/wtS7y
	 aFF7c7dek1JVQ==
Date: Tue, 4 Nov 2025 13:58:13 +0000
From: Will Deacon <will@kernel.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: catalin.marinas@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, leitao@debian.org, mark.rutland@arm.com,
	ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq
 stack
Message-ID: <aQoGdVYOddu9bxLg@willie-the-truck>
References: <20251013013508.74677-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013013508.74677-1-ryotkkr98@gmail.com>

On Mon, Oct 13, 2025 at 01:35:08AM +0000, Ryo Takakura wrote:
> For those architectures with HAVE_SOFTIRQ_ON_OWN_STACK use
> their dedicated softirq stack when !PREEMPT_RT. This condition
> is ensured by SOFTIRQ_ON_OWN_STACK.
> 
> Let arm64 use SOFTIRQ_ON_OWN_STACK as well to select its
> usage of the stack.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> ---
>  arch/arm64/kernel/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index c0065a1d77cf..15dedb385b9e 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -62,7 +62,7 @@ static void __init init_irq_stacks(void)
>  	}
>  }
>  
> -#ifndef CONFIG_PREEMPT_RT
> +#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
>  static void ____do_softirq(struct pt_regs *regs)
>  {
>  	__do_softirq();

Acked-by: Will Deacon <will@kernel.org>

Will
