Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7015D5C4;
	Wed, 20 Nov 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088781; cv=none; b=teZ+ihMA5TlvVIMUh0SUdUc2i53+6RvSpatG8M8f+9Yt5WXLGvJfeqMk0wbVtOdnTUiAWDhuWcoPkIquf7W0AR+91Glq1l/5jAczoU2xYXwe7esIdjgDfUGAwASDDk6Lr5zn5T/2ymqiDOVzIGgDyJpnyaP1XW5efHmKk0mC4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088781; c=relaxed/simple;
	bh=D5WgUsL2ipnxJE4L9wdWyb88uva9VzMmPzQMjB4IrMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtrnCiFk6IZdxyWda8V2X6mHWHKA2zIDHrQTem1Q23nyq4eqqO7ZM7Ml9hyClSlk9EMa8GhtaUjpHUXeaGOQvS9gtFnwvwVibfy8Lwgmi/nFmZaVFiI0TLF7GdMo450pgXDyjrdmbJTCGmD1/7euGSnXVB9uo9w6R5iEZtD6LUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afs4FKcs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afs4FKcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1F5C4CED0;
	Wed, 20 Nov 2024 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732088781;
	bh=D5WgUsL2ipnxJE4L9wdWyb88uva9VzMmPzQMjB4IrMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Afs4FKcs7y2eGRAcPnlOYvHRtxIExaZLMDRhGXlhOP1a3fMVgMapcUk6bLATxkrMA
	 kjzTuTgxvgcvA6Aw4LPfwYcFYnkNn7mM/Jlh6hyEq2/2Bovcq/4xY0InZGErhPzFuG
	 nWOWpu+gwJsK1iXY11foqu9dsafl7LMPKb0eqq4QMNFnjAeqNLMUrLE51oKUIChmdD
	 +R6BVcN7qoURnLXItEBu287Tghg5Bik5BKGju+bzv/En3Y7/B/R/1n8gOTax5Xx/Z0
	 LC9b/ZVsy86vqwo8Vm1ivNU8TovOGIzmaEgm72KgOwqa0DatfbqxkB1bSVxqaMQgWN
	 Xpj5SNqoTVMGw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e44654ae3so826113166b.1;
        Tue, 19 Nov 2024 23:46:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWH2xT53+xohNup4axn7ync3+QuAMIy8Q1oYXDPuvSe4rCqzECoP/BS/Gsvhu1ih1uqD0mYLz+mT67EAPGvAg==@lists.linux.dev, AJvYcCWjfoQSfPqvChtMDqCyexlOzlqUBKJPLYnqxd+7Z8POVjV8GfylqO/BPwUAeHMXHNedH8OvxOdC+hKP@lists.linux.dev
X-Gm-Message-State: AOJu0YzKyPRtJDvdvVqOljcVrprGqk+RsNnf+HhWxTFDuGEykfUaOAdC
	YBgbxO0XoNoJGtayb2eQAeyxC8C61Dq5HIi/ELz//z2bLaRgmcblSARZKtrzKPMHNdC3MRothUA
	RGL+VQuF3P5PKeBQ35NAF3JCvxFA=
X-Google-Smtp-Source: AGHT+IH/pUxw2sNueyn0x3c+1sIRSsDc0GAf84s6TqqTUMwuBQ+OJrRw7nTMMn5iusOqcT8AlaxXaE14zfBkwyJgVo0=
X-Received: by 2002:a17:906:6a18:b0:aa4:a814:3f69 with SMTP id
 a640c23a62f3a-aa4dd5304bemr174664466b.4.1732088780005; Tue, 19 Nov 2024
 23:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241117053740.3938646-1-chenhuacai@loongson.cn>
 <20241117054017.3938700-1-chenhuacai@loongson.cn> <20241117054017.3938700-2-chenhuacai@loongson.cn>
 <20241120074049.hw2lHvyM@linutronix.de>
In-Reply-To: <20241120074049.hw2lHvyM@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 20 Nov 2024 15:46:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5P5KOZiv1C68R4notkjwkoTd49=t_09cifXLGLRKDNCQ@mail.gmail.com>
Message-ID: <CAAhV-H5P5KOZiv1C68R4notkjwkoTd49=t_09cifXLGLRKDNCQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] LoongArch: Fix sleeping in atomic context for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 3:40=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-17 13:40:15 [+0800], Huacai Chen wrote:
> > Commit bab1c299f3945ffe79 ("LoongArch: Fix sleeping in atomic context i=
n
> > setup_tlb_handler()") changes the gfp flag from GFP_KERNEL to GFP_ATOMI=
C
> > for alloc_pages_node(). However, for PREEMPT_RT kernels we can still ge=
t
> > a "sleeping in atomic context" error:
> >
> > [    0.372259] BUG: sleeping function called from invalid context at ke=
rnel/locking/spinlock_rt.c:48
> > [    0.372266] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0=
, name: swapper/1
> > [    0.372268] preempt_count: 1, expected: 0
> > [    0.372270] RCU nest depth: 1, expected: 1
> > [    0.372272] 3 locks held by swapper/1/0:
> > [    0.372274]  #0: 900000000c9f5e60 (&pcp->lock){+.+.}-{3:3}, at: get_=
page_from_freelist+0x524/0x1c60
> > [    0.372294]  #1: 90000000087013b8 (rcu_read_lock){....}-{1:3}, at: r=
t_spin_trylock+0x50/0x140
> > [    0.372305]  #2: 900000047fffd388 (&zone->lock){+.+.}-{3:3}, at: __r=
mqueue_pcplist+0x30c/0xea0
> > [    0.372314] irq event stamp: 0
> > [    0.372316] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [    0.372322] hardirqs last disabled at (0): [<9000000005947320>] copy=
_process+0x9c0/0x26e0
> > [    0.372329] softirqs last  enabled at (0): [<9000000005947320>] copy=
_process+0x9c0/0x26e0
> > [    0.372335] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [    0.372341] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.0-=
rc7+ #1891
> > [    0.372346] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Lo=
ongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/2=
1/2022
> > [    0.372349] Stack : 0000000000000089 9000000005a0db9c 90000000071519=
c8 9000000100388000
> > [    0.372486]         900000010038b890 0000000000000000 900000010038b8=
98 9000000007e53788
> > [    0.372492]         900000000815bcc8 900000000815bcc0 900000010038b7=
00 0000000000000001
> > [    0.372498]         0000000000000001 4b031894b9d6b725 00000000055ec0=
00 9000000100338fc0
> > [    0.372503]         00000000000000c4 0000000000000001 00000000000000=
2d 0000000000000003
> > [    0.372509]         0000000000000030 0000000000000003 00000000055ec0=
00 0000000000000003
> > [    0.372515]         900000000806d000 9000000007e53788 00000000000000=
b0 0000000000000004
> > [    0.372521]         0000000000000000 0000000000000000 900000000c9f5f=
10 0000000000000000
> > [    0.372526]         90000000076f12d8 9000000007e53788 90000000059247=
78 0000000000000000
> > [    0.372532]         00000000000000b0 0000000000000004 00000000000000=
00 0000000000070000
> > [    0.372537]         ...
> > [    0.372540] Call Trace:
> > [    0.372542] [<9000000005924778>] show_stack+0x38/0x180
> > [    0.372548] [<90000000071519c4>] dump_stack_lvl+0x94/0xe4
> > [    0.372555] [<900000000599b880>] __might_resched+0x1a0/0x260
> > [    0.372561] [<90000000071675cc>] rt_spin_lock+0x4c/0x140
> > [    0.372565] [<9000000005cbb768>] __rmqueue_pcplist+0x308/0xea0
> > [    0.372570] [<9000000005cbed84>] get_page_from_freelist+0x564/0x1c60
> > [    0.372575] [<9000000005cc0d98>] __alloc_pages_noprof+0x218/0x1820
> > [    0.372580] [<900000000593b36c>] tlb_init+0x1ac/0x298
> > [    0.372585] [<9000000005924b74>] per_cpu_trap_init+0x114/0x140
> > [    0.372589] [<9000000005921964>] cpu_probe+0x4e4/0xa60
> > [    0.372592] [<9000000005934874>] start_secondary+0x34/0xc0
> > [    0.372599] [<900000000715615c>] smpboot_entry+0x64/0x6c
> >
> > This is because in PREEMPT_RT kernels normal spinlocks are replaced by
> > rt spinlocks and rt_spin_lock() will cause sleeping. Fix it by disablin=
g
> > NUMA optimization completely for PREEMPT_RT kernels.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/mm/tlb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> > index 5ac9beb5f093..3b427b319db2 100644
> > --- a/arch/loongarch/mm/tlb.c
> > +++ b/arch/loongarch/mm/tlb.c
> > @@ -289,7 +289,7 @@ static void setup_tlb_handler(int cpu)
> >               /* Avoid lockdep warning */
> >               rcutree_report_cpu_starting(cpu);
> >
> > -#ifdef CONFIG_NUMA
> > +#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
> >               vec_sz =3D sizeof(exception_handlers);
>
> How does this work with NUMA and RT? You don't allocate memory and
> everything is fine? Couldn't you pre-allocate the memory on the boot CPU
> before kicking the CPU to boot? And then just assign the memory here.
Allocating percpu exception pages on the own node is just an
optimization, everything can work without this optimization.
Preallocation is meaningless because all pages come from Node-0.

Huacai

>
> >               if (pcpu_handlers[cpu])
>
> Sebastian
