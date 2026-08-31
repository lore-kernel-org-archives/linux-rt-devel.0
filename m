Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3C47DD4C
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198286; cv=pass; b=q19QQuHasGq35kur2wpDaIJzBuCiwe/eURCsg/xOL8YpvdsyfYscTGMczGacRylrWB9i5YHNf6BGrL5ECGDr3rmkZFj7eRr2mGoR+DfHsW4OQsCvx3M3wMhSvTKZUojeeVjqbngsGk+TCSI75UhlqEcQTjgbMK0us66f5xWZERw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198286; c=relaxed/simple;
	bh=I9kfafs/1Bu43ruu/5AtQZH16QoOsZS1EWru04KJq6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHm2OFFI32jr1rYDoYiTbrbpIEIXXOJrlbqq68GL+PGRnCqOpsUxQ3lin8jTL6AI2rOqaQRjp6hiRhVCFqg5prR/i8KS/hFvQ+P/MsT6esVCbulBFueCADFvzZx6S9LAK6s67W+aZadVeuKeEm0ba/5jrMegEK3JOtH8kJAIIAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzmzaEBH; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzmzaEBH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49ccf12bed0so2165e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 10:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788198282; cv=none;
        d=google.com; s=arc-20260327;
        b=TzC4xT1S88TAT9pDxolUD05p2JcSDuVy8PDFYHM5briOdMEaZPxqIP+/8rpD6o8SqC
         7vArAEFCOjzgpOmitCEVTAyVOlvTpo7Y3GUv+3fQlyoTEcQlXkv0sv4mgLe8jKST7mii
         yZMF5NlRqMCUWmqPaiu2o8xaqcH4UZxAYaZjF+TMzNJDU5eVTzXQYI9sqlssg80K5pp5
         hDNSJR9YgZ/DK/tiFZtnwaHuzbcKLLlWRgjF/11Ry8W01wfIuWKPTR+DOqvGjKCpPnWs
         VRFIOkXLCmJwH7qj/3l5z0hahbXjUpFpGVomzk4DETgAsWznni23hr842V5MSKgVR99M
         kEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ISAzL6GuJopoRMWQpQWk2e7HTJAN8rWZ7VQ5HvwdBSw=;
        fh=dXFNmUpwlU8ni2MHNcxT7hiLG2LRV31JSyBXbwaiW24=;
        b=JfshK8qCGZdbYzDBr6Lo6k10Kk2dakBntDv+qHZBcO2vJlSAqvj7dvcof9nMi4n4qu
         XMqE1WIR1d6GuNGHmLJGIcMGOqQuHd/dIINYuCYJ4w0c5Xhi+eD5QSM+o3qg26vWyay6
         12BaF7lld883/2kbFKKvLRKb5FQ5NFBDxc8umifdqM+TP7VwPkL8UFAG8iW40oEHkOpl
         +gsXqVGJdKQi3pVquiz6ycmjHaFjW8puYMsDM9cc87paDnTuWODqH3qPq7iLlTi2GdII
         Mry5Vmttj1moNq/+3XZ01Acv6lbeq5Aj/xR5fE01c5eSGP9886wYeus433FX5I9S99FO
         bNKQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788198282; x=1788803082; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ISAzL6GuJopoRMWQpQWk2e7HTJAN8rWZ7VQ5HvwdBSw=;
        b=FzmzaEBHs6/PK6uM3PECNXMBac9ajVimFfJ8U6hcuWxjKWF55MGO9O70cO8cXDXDej
         lXQP54dcslWl8h0vEBI7++QiGUIi1HBRSE3bNEUrCxtFzDrgmFuG+8IyZMNMXi/Wji/5
         oimBK/xeeS9Qv+lTG+mlpMM/PbeUG/40L3aZ9umdUtup5JVSnFqhkYjrRak58eREVsCV
         kf7ICfyWdI+LjURu8AqEhTZutoi9U3otlfnIsozvoLvzXekpPieqbS4T8LiDBx8FJBPt
         wNzYcfrR8sFn0SNam2a8Xc7rII4dLW3lno+VMabmMExZaztFFVsLmH4x+b/QK19qSNQq
         q0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198282; x=1788803082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ISAzL6GuJopoRMWQpQWk2e7HTJAN8rWZ7VQ5HvwdBSw=;
        b=NZ/J4kNC2ARZy/kFA53WC9kz31TBXmmNpGLYtYPuIutzt0+L5TsTbS8bnvglSgxsc4
         rBJZaRP2mT2X4FMQQ7ntZlN0tmsyzy5aVWhsrDwctuSogCEsr2XrO3y+f1+g8iCzodsL
         v++NbxuHYBqyWSsO/vYLAD9z+SrFx+iwei2RPfNzD57vIgUflrG6noSAfwgBmu9HzAef
         7XmtNrB8v38pEsQE5rsjUkko50anAEV4xEahsqwySs4iR2eO6+0dE2Anaao4gONneRWx
         IOmHru9nun79onahiATnpwFvo5IOwawMNuYICvQeVJcxU6YvVm1M9c15xbxUzussKgyq
         qzeA==
X-Forwarded-Encrypted: i=1; AHgh+Ror2tihohzyOWHpfunrlj4zjScO9LP1uClWaC6v2l/FA94hT2wMEHMNwggpjad4N5aQ2nRpaXaY2aGfsz3qjQ==@lists.linux.dev
X-Gm-Message-State: AFuF++luXO1S+hqeHWBbvkjTPO/I0D55MXKSBKr0WrwRB632SO/ya6/R
	AxBdnWM8dSalou2Fypfq/1P6JTVblyAGTEtDLMzPImlGrhjncFhGLIakXXm3VffSrRa9vCdu/HP
	9gMt5MQnn+R6OcXIO9MTWg0BJGo+rLxKZPTR0GBz6
X-Gm-Gg: AR+sD10P6MYILigj3nZr5Mbeft70ybGV9dbt7t95abbBqxlz4MImLmmz+RtDthiPwe5
	o5eC8k2ouq0GfQan8biLAvhNW34XKQ8RFtuk6Fl1EoMpahk1MQz9oRLbPvK8o1w6sNkk47DM8f9
	sSLnwOk9XePd6+FVBqdv1KxSRjHxagvs1P9+zSljSc40EzT1wDdTRr4CSZcRaHYaH4b98+qmF4C
	USOieUvVH/lhi7ds85OSP4wT+i689T6DMP4C9J32rIbmd0TcIVX+2VC4qgtv7/+MrdsP7jdIl4q
	TQ9FYe2/ocF++WPe/8mjq8tN5DPGlgyO5HbWWZ51+R3HVxiK8Xqh2fQjCrctZEVKrtThSCnJ24u
	05+411a9QCQRfN+H6yB9tWoMw0G6JC+6QmCP6ccp7l/I=
X-Received: by 2002:a05:600c:6d8a:b0:49b:8eb7:4a7d with SMTP id
 5b1f17b1804b1-49cdd243062mr28165e9.4.1788198281222; Mon, 31 Aug 2026 10:44:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com> <20260827232948.2520558-7-stevensd@google.com>
 <20260828120408.GN687043@noisy.programming.kicks-ass.net> <CAOiLmNHWGSwAqH815X3JWMrQCc2nh-fRNsNZ0hjQGv8JvFndag@mail.gmail.com>
 <20260829083929.GZ776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260829083929.GZ776954@noisy.programming.kicks-ass.net>
From: David Stevens <stevensd@google.com>
Date: Mon, 31 Aug 2026 10:44:29 -0700
X-Gm-Features: AcwNN1WpmAgjgQmF9GpDiXzg08-hj-z0i4rUlR_td_jtRLd8aXHDJ1pfdit0KWY
Message-ID: <CAOiLmNFsuaBf4C9=d5xrdi8SXYgFbjjD7ZnK1+G1=RaHquVinw@mail.gmail.com>
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
To: Peter Zijlstra <peterz@infradead.org>, shakeel.butt@linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 1:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Aug 28, 2026 at 05:18:05PM -0700, David Stevens wrote:
> > On Fri, Aug 28, 2026 at 5:04=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Thu, Aug 27, 2026 at 04:29:44PM -0700, David Stevens wrote:
> > > > @@ -4320,8 +4319,18 @@ int try_to_wake_up(struct task_struct *p, un=
signed int state, int wake_flags)
> > > >                * A similar smp_rmb() lives in __task_needs_rq_lock(=
).
> > > >                */
> > > >               smp_rmb();
> > > > -             if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flag=
s))
> > > > +             if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flag=
s)) {
> > > > +                     trace_sched_waking(p);
> > > > +                     break;
> > > > +             }
> > > > +
> > > > +             if (!ensure_stack_is_present(p, &need_deferred_repopu=
late)) {
> > > > +                     WRITE_ONCE(p->__state, TASK_STACK_RECLAIM);
> > > > +                     do_deferred_repopulate_wake =3D need_deferred=
_repopulate;
> > > >                       break;
> > > > +             }
> > > > +
> > > > +             trace_sched_waking(p);
> > >
> > > Absolutely not; ensure_stack_is_present() must not call
> > > repopulate_stack() while holding ->pi_lock. Not happening.
> >
> > The optimistic fast path for repopulate_stack() could be modified to
> > try pulling from a pre-allocated pool of zero'ed pages. That would
> > reduce the function to a couple of memcg_kmem_charge_page() calls and
>
> Afaict memcg_kmem_charge_page() ends up in a local_lock, which is a
> spinlock, so that cannot be.
>
> Most, if not everything, in mm/ is build around being preemptible and
> thus not suitable for use under raw_spinlock_t.

With the recent work to make memcg charging NMI safe, I had thought
that charging from within the scheduler would be safe. However, you're
right that the fast path does call local_trylock(). I didn't realize
that only works because of an in_nmi() check inside local_trylock().

Given that NMI safe charging requires only using trylock and handling
the !trylock case, it's not infeasible to have an implementation that
always skips the trylocks.

The alternatives to that would be either not uncharging on unmap, as
suggested further down the thread, or using deferred charging.
However, both of those approaches would make memcg charging less
accurate, which is not desirable.

> > then vmap_pages_range() to repopulate the stack's page tables. That
>
> vmap_page_range() can end up in the allocator, which I suppose is ruled
> out by the vmap having been populated before, but it still has a
> might_sleep() that will scream AFAICT.

It looks like when we go through vmap_small_pages_range_noflush(), the
might_sleep() check is missing. That would explain why I haven't been
seeing errors.

We wouldn't want to remove that might_sleep(), so I guess this would
require either a new function or flag to support mapping into existing
page tables.


-David
