Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DFC16DEB5;
	Wed, 20 Nov 2024 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091731; cv=none; b=dOpUOnYSrbm85i3YqPW91atHjrCaVsOHK6rj/9LZxQmqVE03OH4QADdn6G05MKR9QW3fvhABY2MQFVezIQ0VUR3k+gy4dxrqWQ0X5yMhMaddeYHX8nL79DYRz3C6Y+1yuqEGAxVqKPdqAL1A0+8gMc/f1ibiOnK8gYkEVIynLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091731; c=relaxed/simple;
	bh=mc8diBgNopIHFTelzM5G4DMtbIaK65mdQzVliWRL0tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHJyxaAtGCNFwFhqNIj/S7V72//NR1pZ201+Dc2f9X+JehxLe57ryrJ3b9dRPeT0/9oon3fYgg+YgXDPmPaTCA7dbMB6T/CdGZj1lKmAHE+PuoeLJl+s/phAP9zDyVaHLFSlbLJ8WMHewio0NXYaSIkltmyESccqsLVjs0MJFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mblm1ovc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mblm1ovc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FB8C4CECD;
	Wed, 20 Nov 2024 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091730;
	bh=mc8diBgNopIHFTelzM5G4DMtbIaK65mdQzVliWRL0tw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mblm1ovcpyj5x8onfyiVnWF9bSIZh3Kvyqte0wzfzJRk6+zWcDQSILhPTjh7EzBnz
	 GVwbLI654YPewGzkuBRHAGkUH6WcQnPR76Ys23ZF7bKyteeG3zGVTT5/QVgRc3aaVu
	 6q4lO3Ffdu+MU1VSIjXCUmuMYRZjZCclDw6McWy9FbiEDw/K2SnkKxd+NWVJNZoT19
	 2uqQ2qmtbqge4hMNAYPZeGF0dSyEYieJd4RbhI8kmJmdmDjydYjlRHUXJGdsG2ATYq
	 Yg7XhZAKyGNwRky+2VI1Z0/GEzuQGUUGlnIYv/UdlX21n5/qWucVTUNl5gq2gYImW0
	 KGfXGZ3nIa22A==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa20944ce8cso107599866b.0;
        Wed, 20 Nov 2024 00:35:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8ONA/Gun84Ye/p0rW7eioVeqtyXqZlF15Zw5f8nBlARlQxMvAMF3Dlj0dZ0PPMyHKxpdJCuIjgAY1YcYi3A==@lists.linux.dev, AJvYcCXa9SkNgiFMt9Ybw/pCfRgU23Z919GtsPIRoRKRB0rhGnqF62ynqzyZRa9xBTnp9ej8pVeN8lNi3mOh@lists.linux.dev
X-Gm-Message-State: AOJu0YzYdxc/BRCUaavVQ/2uu+T6Vn6rwv2FB2p9JOQ7g4W7TZMRAkOQ
	Yg2q+7J8Fj78Muz3xxGss9UFE7aonY61GeeAfIAsLciGDFmmP5/L6lm7EeND7996CmwFzufnLMX
	gtoUttM4kK6+rABTpcxt1xf5I5vg=
X-Google-Smtp-Source: AGHT+IFmws545SYxTgvB/vvM+jMzZDrfY85tee1Ph89YpNZoRK4yWvhxCua405+jQ8XFpNoMzsw5ILp3F6+v5rXHvRw=
X-Received: by 2002:a17:906:c10a:b0:a9e:c266:4e82 with SMTP id
 a640c23a62f3a-aa4dca3c650mr197332666b.6.1732091729215; Wed, 20 Nov 2024
 00:35:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241117053740.3938646-1-chenhuacai@loongson.cn>
 <20241117054017.3938700-1-chenhuacai@loongson.cn> <20241117054017.3938700-2-chenhuacai@loongson.cn>
 <20241120074049.hw2lHvyM@linutronix.de> <CAAhV-H5P5KOZiv1C68R4notkjwkoTd49=t_09cifXLGLRKDNCQ@mail.gmail.com>
 <20241120080521.ynDZpGQd@linutronix.de>
In-Reply-To: <20241120080521.ynDZpGQd@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 20 Nov 2024 16:35:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5euU0Cm=YE=FM2+B0cSKCWsHt+PzUkhAfAgaNeKAEgFg@mail.gmail.com>
Message-ID: <CAAhV-H5euU0Cm=YE=FM2+B0cSKCWsHt+PzUkhAfAgaNeKAEgFg@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] LoongArch: Fix sleeping in atomic context for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:05=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-20 15:46:08 [+0800], Huacai Chen wrote:
> > > > diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> > > > index 5ac9beb5f093..3b427b319db2 100644
> > > > --- a/arch/loongarch/mm/tlb.c
> > > > +++ b/arch/loongarch/mm/tlb.c
> > > > @@ -289,7 +289,7 @@ static void setup_tlb_handler(int cpu)
> > > >               /* Avoid lockdep warning */
> > > >               rcutree_report_cpu_starting(cpu);
> > > >
> > > > -#ifdef CONFIG_NUMA
> > > > +#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
> > > >               vec_sz =3D sizeof(exception_handlers);
> > >
> > > How does this work with NUMA and RT? You don't allocate memory and
> > > everything is fine? Couldn't you pre-allocate the memory on the boot =
CPU
> > > before kicking the CPU to boot? And then just assign the memory here.
> > Allocating percpu exception pages on the own node is just an
> > optimization, everything can work without this optimization.
> > Preallocation is meaningless because all pages come from Node-0.
>
> Don't you have alloc_pages_node() where you can set the node?
This function is called when a non-boot cpu is online, at this point
NUMA has already been initialized.

> And I mean pre-allocation so you don't have to allocate memory here but
> already have it ready.
If the per-cpu exception handler page is not on its own node,
pre-allocation makes no sense. The performance is the same as
disabling optimization (use global exception handlers).

Huacai

>
> > Huacai
>
> Sebastian
