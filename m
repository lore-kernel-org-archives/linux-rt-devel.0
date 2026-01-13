Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112D352C26
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347260; cv=none; b=R79oAR1fEPpXn/Lzx+qRN2CPO/8QKMl6WUSJx4a5hSuDA8h6yOlNmhT6x6rdp10BY1jxkecwgv1y4hE/zB+F9qellYUsLhz9USd9rProiUo9bKJk/tXR57ugfhBda0ingQGplWjDaZ6xrirnd/alvLYdsZ6FIusrmOYVsiJV8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347260; c=relaxed/simple;
	bh=vSIHbN/AFsi9IyiiDINfkuH9r4GDwCzfGxmBEllwNAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOYR1YCOjPdditXmX8GTKrVaTypKi1CmJuCYHYd1FyJkxi9++v/kSsPcUufsfkV7MOOKFr7eyyzEr3y6NInFGfl0af5933IOZFX+MI/GEolnG0hlzmaPKeu3/ATyRTpkPSuiGh8HZQGPh1uJOs4RPASxqO1uw4yiokuk4uHOFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifLDAQ6r; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifLDAQ6r"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327778df7fso5057620f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 15:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768347256; x=1768952056; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7s9rxJWckSpPn5eremPzEyroaJb9H+mV+4Z95ehOgA=;
        b=ifLDAQ6rfb9egVBvL0qQMem2JiK8ea2wi0Fq4dhs+LSxjLeVbiA6JHw0JJbXtbKjKh
         42u8q6EwKKFyM9k3VIlWyFGWIg4wD+BB6c4EDo4UfyPhjHVT7U11/oVj4AaUhZWI6fwc
         3avLITEIkxXhIV7sGdIKsOnf9HXPE8B9n/N+ZBIJhDlqZWwLdcohVNjBs1mjKMpqCZYl
         lmNShA2O5v4CM4G/yZU0XjYXB3fmBr4clfZL3d/VIl2H+2jqtRcCc0ownHI4p6y1WNay
         jJEKFNFCbi/0QXDPxRX0EJL4ozKR6dRh/aYisTLg58Cv8xHazrCrCmtunb8txbxitb+G
         nWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768347256; x=1768952056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7s9rxJWckSpPn5eremPzEyroaJb9H+mV+4Z95ehOgA=;
        b=aRZgPEavhFhzLRUu+OszVRul1H0kEiJ1gMuHX2xtRcD0lbyQaiUnMmyFYE6OjUZxw9
         NaVOqOj7kv9UoPp8iU52a+MO/W0z1zZPDDHnXP4Ed4BUxDIMpfCn01x8XCvyP5dqvEAc
         MqM41ySIGyVu/8K4ktvCojvTnchChJsEsPDVaMiRhtcEQzZcxycuJbI4GJCEIXGdosBB
         TK1SDfH7irfVLaO4rE0QH7F5+07rdMLXEjY5h77QhOoEClHXKHURT6kpDCjOK8BnZ8su
         IvjaZD0+3ryC24EVRjB5MXBReNogIPyfmrcphGgrIeN1LDjY27OjkzCAEpPh0Ch23CwT
         SE8A==
X-Forwarded-Encrypted: i=1; AJvYcCXS+HO6n66YzaZtW6FLYG9a/Ae+eAdVHK2T+tq+4RRXAZuNm/hzPVbxwMAdR0ZPZ51nFMCC6/R/DMwlJp4JnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7BoxzSTJeyVTKrXj0vzZ9H0AeU+HkY0f9/OE7zm2ntss1x7kF
	/6IbtUel9KX1f6RsrxCvOr5rIrCcvXdTthzPk6+OJMoKgvQaaw/jX7szy+0+nvJh1yisOIFs8xz
	evd3dlpMcETFPgsCIYDOv0Ad9wrZ+4JY=
X-Gm-Gg: AY/fxX4F+TlFyk9rxcvxi6wIhO7AhxIj3er/Pn7I6YfObeXINFTPa49eTXNUzCRgqdl
	PZeRJExvasZc9woomdsdk6t73LYOl+6/+0x+vYTHv79uS9ElY3xl3X0JBedviBlb1tgdYrXcn7z
	ES9R5NvvIVkrIDA5EhNVwCIvjskmw+sgY+lNwmkf2pBg6txflD5aIvaomo688YgxPxUp5KGe2pP
	/fZnZQJJd06xduzHSLzrEmzjvLIw5TA9Lwuj8hSka8ouflz0rx8a7r+rDdlR68Ss49yhVG49ajT
	E0n1FiCpyUlb8lNHjuYM0SKn2s/x
X-Received: by 2002:a05:6000:4284:b0:431:9b2:61c1 with SMTP id
 ffacd0b85a97d-4342c4f40dfmr471528f8f.6.1768347255789; Tue, 13 Jan 2026
 15:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260113150639.48407-1-swarajgaikwad1925@gmail.com> <20260113180036.Zl8j3vIY@linutronix.de>
In-Reply-To: <20260113180036.Zl8j3vIY@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 15:34:04 -0800
X-Gm-Features: AZwV_QjYt435EovaX3Vefewc_Yb9AEHtH7N6cRpOO2cyq9Oe5XpDAMX_LWYuCTo
Message-ID: <CAADnVQ+no23M8x-00yZXHo=0BqwwR0kyq8Z=oE9OK8G71PO5Yw@mail.gmail.com>
Subject: Re: [PATCH v2] slab: fix kmalloc_nolock() context check for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:SLAB ALLOCATOR" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	david.hunter.linux@gmail.com, 
	syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:00=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-01-13 20:36:39 [+0530], Swaraj Gaikwad wrote:
> > On PREEMPT_RT kernels, local_lock becomes a sleeping lock. The current
> > check in kmalloc_nolock() only verifies we're not in NMI or hard IRQ
> > context, but misses the case where preemption is disabled.
>
> The reasoning was different back then.
>
> > When a BPF program runs from a tracepoint with preemption disabled
> > (preempt_count > 0), kmalloc_nolock() proceeds to call
> > local_lock_irqsave() which attempts to acquire a sleeping lock,
> > triggering:
> >
> >   BUG: sleeping function called from invalid context
> >   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128
> >   preempt_count: 2, expected: 0
> >
> > Fix this by checking !preemptible() on PREEMPT_RT, which directly
> > expresses the constraint that we cannot take a sleeping lock when
> > preemption is disabled. This encompasses the previous checks for NMI
> > and hard IRQ contexts while also catching cases where preemption is
> > disabled.
> >
> > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock=
().")
> > Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Db1546ad4a95331b2101e
> > Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> > ---
>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> for now.
>
> > Changes in v2:
> > - Simplified condition from (in_nmi() || in_hardirq() || preempt_count(=
))
> >   to !preemptible() as suggested by Luis Claudio R. Goncalves and agree=
d
> >   by Vlastimil Babka
> > - Updated comment to reflect the more descriptive check
> >
> > Tested by building with syz config and running the syzbot
> > reproducer - kernel no longer crashes.
> >
> >  mm/slub.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 2acce22590f8..642f4744d5c6 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5689,8 +5689,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t g=
fp_flags, int node)
> >       if (unlikely(!size))
> >               return ZERO_SIZE_PTR;
> >
> > -     if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> > -             /* kmalloc_nolock() in PREEMPT_RT is not supported from i=
rq */
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > +             /*
> > +              * kmalloc_nolock() in PREEMPT_RT is not supported from
> > +              * non-preemptible context because local_lock becomes a
> > +              * sleeping lock on RT.
>
> I would say that despite the _nolock() suffix a local_lock() is still
> acquired. The !PREEMPT_RT does a trylock.
>
> As I noticed this myself today while looking at other patches, was the
> trylock removed on RT by accident, was it there only in an earlier
> version which was never merged and will it ever come back so we can go
> back to !nmi || !hardirq?

The root cause of this syzbot splat is preempt_disable() in
trace_virtio_transport_alloc_pkt() that is being fixed separately.
I guess this patch doesn't hurt, but I suspect with tracepoints
moving to srcu_fast syzbot won't be able to find
preempt_disable() + kmalloc_nolock() case

Acked-by: Alexei Starovoitov <ast@kernel.org>

for now :)
until shaves come.
