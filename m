Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4215853B;
	Wed, 20 Nov 2024 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089925; cv=none; b=IAHT013EEd9bCDkp//FNSL2ZRr/xKKTZh0NylJyZMFc6Eny0N3IT5d06uDKUPW9PEuzav70noIkV6pdonkiuABeS3DWCgXVTG+KfKOpXgVTTqlD2H2x284Mc4I5oNmrSW+7D5/Yv+NrFfhALSRtMv64MIvgCf4vMEeBEuHc8Zkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089925; c=relaxed/simple;
	bh=+XfZ6aH67RuphEum1sNMs/bFLTO1I8SN/QSDRfT+fFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAyxpMoOViNx5CZcyYP0agDID0YU3bBTHlFNWFyHrEYI3fcT89yP7YBV/U9jgSD7pgCGWyc1NqmMC/7jKoTSy9YIORTvBo16S939Vzv12u0sDo37n3vtdEf1o+sdq92Yogt5lDWuy0Tzs88bDKNGuFfpDZsDbaXg2e8O+837FDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kvaz97s2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVi2K95v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kvaz97s2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pVi2K95v"
Date: Wed, 20 Nov 2024 09:05:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732089922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs0hoPbsHkv5OU8T4saAvd9rGQoJb3WXfsMJDKAk3GM=;
	b=Kvaz97s2Lj9hLl9EdGilLgbw3ybjqljCYIKDdtypaur7sg1NhlrQSFmgEDgKiQu3k1QO4X
	p6fVrxOeiSGuevlhL+CWVMGP3cASc0ar/7n+17Nt9CxaXYhvjnYpCT6SUKIuL9op6AltCG
	TOlHGD2BkCPUnkmqGfW5ApB+j4Yjk+Bpf12Du+P6ZKEVyO3+HbeLc/vgk1+aJUyGn7K+Kn
	HDOKhG5KkbAGotxqm/7n19ZXm6K3tKXUGjt9/D7q8YyeNFtCYpg/4zx2pVneJSOcYoxQ3W
	rz+voQsbpu7Iwqbtt32+iMwjjO4aDCJMWsB2sxuQ/Bam063OT5OI3Rg/mnrU2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732089922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zs0hoPbsHkv5OU8T4saAvd9rGQoJb3WXfsMJDKAk3GM=;
	b=pVi2K95vDXXsmcVaHSVxEDy1KuLm3Snn4xzk9Z7RFLGmNDd2pkBBXsd2GV5g+9uweW2EHZ
	XnR8/Hrp9UvXL4Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH V2 2/4] LoongArch: Fix sleeping in atomic context for
 PREEMPT_RT
Message-ID: <20241120080521.ynDZpGQd@linutronix.de>
References: <20241117053740.3938646-1-chenhuacai@loongson.cn>
 <20241117054017.3938700-1-chenhuacai@loongson.cn>
 <20241117054017.3938700-2-chenhuacai@loongson.cn>
 <20241120074049.hw2lHvyM@linutronix.de>
 <CAAhV-H5P5KOZiv1C68R4notkjwkoTd49=t_09cifXLGLRKDNCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H5P5KOZiv1C68R4notkjwkoTd49=t_09cifXLGLRKDNCQ@mail.gmail.com>

On 2024-11-20 15:46:08 [+0800], Huacai Chen wrote:
> > > diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> > > index 5ac9beb5f093..3b427b319db2 100644
> > > --- a/arch/loongarch/mm/tlb.c
> > > +++ b/arch/loongarch/mm/tlb.c
> > > @@ -289,7 +289,7 @@ static void setup_tlb_handler(int cpu)
> > >               /* Avoid lockdep warning */
> > >               rcutree_report_cpu_starting(cpu);
> > >
> > > -#ifdef CONFIG_NUMA
> > > +#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
> > >               vec_sz = sizeof(exception_handlers);
> >
> > How does this work with NUMA and RT? You don't allocate memory and
> > everything is fine? Couldn't you pre-allocate the memory on the boot CPU
> > before kicking the CPU to boot? And then just assign the memory here.
> Allocating percpu exception pages on the own node is just an
> optimization, everything can work without this optimization.
> Preallocation is meaningless because all pages come from Node-0.

Don't you have alloc_pages_node() where you can set the node?
And I mean pre-allocation so you don't have to allocate memory here but
already have it ready.

> Huacai

Sebastian
