Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D981AA8
	for <linux-rt-devel@lists.linux.dev>; Sat, 29 Aug 2026 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787962701; cv=pass; b=MotSYl453M3QE6frA8/XSYvLhJt0MmP0PTyJ5uIHYMhR4Po2j4i52+c7nc1pudKC5bi127yCQcISCfRbbn35gtsqLEzEW4r8Rw8Y2CsgWpkDO41yfV1H8m9AFIc0w8xglU9NDhpOSXF3w5bytQMqwRtsprqZhDBsbtTVeEnLBPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787962701; c=relaxed/simple;
	bh=EpZWMqJMFNnhSBqC/WC1fi00kpn5Ll9AMHDCeclZHmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7nAJWHGrJMz6H2qZ4ousHx3WZLp9CBmHaeVPcqOD/8Ji6gNaRlMLEFZ5buiUlvgg6JGAwNcLR0k6bLXSlUEhbkIyI6Q0XIW35CXzyQkoC3ifQQ9L6nQ26JIKVNcA57SlVhgOvsZzuk2JPNNDQ+3xfq14cl1W1q5mRoPhjPMVCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p28uVwxQ; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p28uVwxQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499b1409a75so8405e9.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 17:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787962698; cv=none;
        d=google.com; s=arc-20260327;
        b=ejiBZrdN96AyCIIlK2Hj901rxdOV9/ZLfTjWBnHXg1lAoqRC7birRclTZh2f14S44+
         I2oUpu1p3IqIhhk9YiL3q39OoFs3gVrgqQdLAbMl/tZrckryDpOvso1tg8Dnlt/xBoZt
         v7Per8h4iog4S9Yh3FSQl+rT7Mj7q2W6bv7FxdMq5Bgq/PHo+71TEz/zGaEn5hxu32bl
         JKTzSHY8aaRMBvlqw1OGSZWoGxj5ytMqFIMxb0x0KxjjTWURJ295TV5qpWqqsFcNf0tW
         QIWGtKE9XkSiORh9BNs7c5FMhwE4DmhIW9dYN2xWCZaY6AA0gAejOYiA9WIGbx33W13w
         u+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=92zwtXlgyBYYVN9xkl2KGrhKya15L+GyHSeWZLE5yFc=;
        fh=5rhV+Q5nAoboau+fT27iBt39xP58F2eBL+0+P7m/omg=;
        b=SXcisXhyxlk3oxaOjyqhTPMB71bUs/sWYnna7wVM6Ucymd6UrJkjucfSc7ZnkCgPPV
         3jsXIoxUovD/ZKfi/XNb+9AvF5jdsb7dDl5Yo1/uv/qNUBWyFrPTNDS1dzP7yEmTsgaD
         dVEUyTT2S2BjgnPpMhuZB73rrT+XB37knWGsT0tJoxHSgwmiIZ6uKKNYmkdYnCR9geLg
         o5SaH+xaKJpqvVB0RCLwFTYWj7SqIacAAmMzJhdzGrjH0hKJHQori3Ajz8ZOLnpkuYra
         sx4NIruyIn5emb3l/294HJjxTKi7LubV6azCsylhjy3KTCZt87L6RyexE0jQcA4hMuup
         heOA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787962698; x=1788567498; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=92zwtXlgyBYYVN9xkl2KGrhKya15L+GyHSeWZLE5yFc=;
        b=p28uVwxQzTcMnowvKWLT2islKHcw5HXgbpUms86uzjpGvpJjwdyqTQkv8yfXi4c+wh
         U5tRK/FMYpUXWRKN5Wu/ETd3ZVok7F1LdHD5wNc1oS89jHVr1662P/mS1uCiw4cKy2v9
         CvPhOeADPD7jm59YqjS1y8f7icNHtwItXtrZESnaKLt+ZWOvIlDATtNBaw8lFnX7U/kx
         pilzFNjS81RXaXphCUUDG2r6bN0QKiCaUS3DOrIGicQHzr7htq4UcFeLJ0cumY6NI4Ub
         EjaqgS6xuePTUpV7gXuoC3yGdT4e1TxrAg1Pk1LQDiktwfG1I+aLWzXbDcmu7ffCj3mR
         AHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787962698; x=1788567498;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92zwtXlgyBYYVN9xkl2KGrhKya15L+GyHSeWZLE5yFc=;
        b=JmiVWpuVVGUluTQ3JnFsfey2vGq5NXhH2qFNefhumLrgKDdeDZ3QSAcbznKgKwDTmL
         uzz4NOxzLkLyZsUtBnEJGnyIS+F/174aK3AvTYdph/jA7nVGtxWw34vTwsGrB7m6/N0N
         R4JIOaHLmAUyUuiQiMFoHAopsIClXX+ackQ6Xu/b8D939wzCBV5OxPoxlTM/0HoFnH7r
         siSOMYcJIQ747h5bPgtEeRtFbFZgigUv1MoJZnYdXg1YmDNR3wrbRVJWP418eKo169R1
         /BRlXClb09iKzpBQ0aB8HChOMbqY5jIVNJVF+1IVpvNi+EOBkybtUxRsPZz4u8mUN+SH
         DCkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8rWlTnc23z1GzuD+RAWvOgXSlJOFP2Ap3cTRxfBmqrWoE5CYMMPN5p1I9Z4HRzGsTu4s1egkYfeQVYfKstg==@lists.linux.dev
X-Gm-Message-State: AFuF++lrINAxzZC53xfC+3DrEBEdMKLP8N8D5HNizwJyQcXlGcVc0ICn
	hT7ImfNkUq3Qv/AxI8yDxJ19zmKcLb+IiatioArMZHva4f8aLUrPx7GeX0sngtiAtsctApNlIw0
	pyVd/fYL4MOK7AufYq89E/oFYzZmFptjvCJmFYvBR
X-Gm-Gg: AR+sD12dK1XjtmfzfRWyzjgU6/du/fVq3eBi7W1v6WOixRwypkz543Xc4h8J4y1DI/J
	l9FQPZ/del9+NdKjeDC5VPE8q+fdcHPFozG/PgYnV9nLMHw5op8+0v/dt5+QHchoG3gmQNqnLzX
	WUm3k3k8hU2A17XyW1hOXrb1431UMPjYAF2+8tA4iVxWqIox7oAWZZoPxcIq+/7O4QZPdgwRo0w
	S8QZUp+2uDFU3a0azF1Sp3iAfVBlFa7ihDjCwIqZNEds75Rolkfr0MMF68P8+lK8WZ49uPzfd9+
	Bls47CqSlOT9NzU+EM5pAdGiu/sNC0PegSKZVJ4kQajRC1dREN64zAsjoxyIput5ju8yTn8W8xY
	=
X-Received: by 2002:a05:600c:6051:b0:499:c46c:addc with SMTP id
 5b1f17b1804b1-49ccbb107damr428575e9.2.1787962697528; Fri, 28 Aug 2026
 17:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com> <20260827232948.2520558-7-stevensd@google.com>
 <20260828120408.GN687043@noisy.programming.kicks-ass.net>
In-Reply-To: <20260828120408.GN687043@noisy.programming.kicks-ass.net>
From: David Stevens <stevensd@google.com>
Date: Fri, 28 Aug 2026 17:18:05 -0700
X-Gm-Features: AcwNN1U6VBNd8zJTEq4mYD8VweLtljSgvulTToePYb44m-5Q8rEJ_yFqUyGXmiE
Message-ID: <CAOiLmNHWGSwAqH815X3JWMrQCc2nh-fRNsNZ0hjQGv8JvFndag@mail.gmail.com>
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
To: Peter Zijlstra <peterz@infradead.org>
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

On Fri, Aug 28, 2026 at 5:04=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 27, 2026 at 04:29:44PM -0700, David Stevens wrote:
> > @@ -4320,8 +4319,18 @@ int try_to_wake_up(struct task_struct *p, unsign=
ed int state, int wake_flags)
> >                * A similar smp_rmb() lives in __task_needs_rq_lock().
> >                */
> >               smp_rmb();
> > -             if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
> > +             if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags)) =
{
> > +                     trace_sched_waking(p);
> > +                     break;
> > +             }
> > +
> > +             if (!ensure_stack_is_present(p, &need_deferred_repopulate=
)) {
> > +                     WRITE_ONCE(p->__state, TASK_STACK_RECLAIM);
> > +                     do_deferred_repopulate_wake =3D need_deferred_rep=
opulate;
> >                       break;
> > +             }
> > +
> > +             trace_sched_waking(p);
>
> Absolutely not; ensure_stack_is_present() must not call
> repopulate_stack() while holding ->pi_lock. Not happening.

The optimistic fast path for repopulate_stack() could be modified to
try pulling from a pre-allocated pool of zero'ed pages. That would
reduce the function to a couple of memcg_kmem_charge_page() calls and
then vmap_pages_range() to repopulate the stack's page tables. That
wouldn't require touching any locks except a raw_spinlock protecting
the pre-allocated pool (or just make it per_cpu). In terms of cost,
this would involve a couple of atomic operations for the page pool
lock and the memcg charging plus non-atomic operations on 5-10 other
cache lines.

Is that within the scope of what can be done under the pi_lock? If
that's still not happening, I can see how things look if we always
defer wakeup to a workqueue.

-David
