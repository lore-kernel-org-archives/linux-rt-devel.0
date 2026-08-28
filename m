Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD63AF660
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939921; cv=pass; b=px0PihCYVFYhnNuEIzdK2ZoX4HG9++HcoNq7WqucDJLmeVNtia3xmAVPc+pDbsLFPXAsnPKb0BHRnjsqqEuz3852tMy6MX3xf/mkABq4ptM4Hn/yeb7SPSTBPRkDdPMsKtSY3aX4o8jtj0JTugRsou5FTG+zBzkttBchZ3+duJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939921; c=relaxed/simple;
	bh=R2koS2vCzM8w7VNNntAyqh354TzQoKL9/yGNgBa5fxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPV5utSVY1AKCNIAFm7MW12lSlojuhcFgL0h2Eh+2fvB5QhEdo4w0scscNk3sk84PKYTgxK8BS06zGmR9XLnscdyZGUIQsjt+Zs8G2rSZLkmoeZf3jtdEBt71DnfVWIoWiDppPlA/OgNpyU5qSETXdxUxI1uIZgmnZY+hcY7wGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oX1+XCds; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oX1+XCds"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-499b1409a75so2685e9.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 10:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787939918; cv=none;
        d=google.com; s=arc-20260327;
        b=RH7x9BPQABPeyyduz+8CdI8MHlwhtE/qZB9yCyOQREDOfJDVxBP/roqg+G8V/deAyv
         KeoUvFNqzOnWQPD3Ce/86lnJFyR4ZZoteoYzq0yXN3hANy/MZdLx0Y9emrluObRJL8Cp
         tzgKjBIwVG0Sri1s6uXcE83QeHuGH8L1Ld9WbZg1JY7AMq+mKgIVaanX47b39NyQ5Odj
         RCr3kzARFx+LkeTQJ0oRnRpq5R3h5dTj11Xy/koxhBwFKabL1wUqupeBAQT6GQRqxZi0
         ZX5oLeRrgfPUE3zvS+AbRpHV0vxawZPvoKh34vTYTed36DTS4dWQShGDgXYAlLS46vus
         3nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R2koS2vCzM8w7VNNntAyqh354TzQoKL9/yGNgBa5fxE=;
        fh=zZPBeaUIjQ/2Ho4p5WRKRjvyxfPybh5xuTCQtFKupII=;
        b=McL36EOdgtzznRiLd6eFZ1Fp0umQM6iZjR21xBy3oSe0Jyzh4hLpiANAiXUftSDc8B
         YTB0AvEoV/9vflhV3PtK1jFsro+NM6wX9A9lKGocUCD/J45tBCAC/O4x3we7SFtLDyei
         hPQPNo8/rEe6GTC0jZnnBjlfPTiyzm/yyVAuDsCkWyU8Rc1+8Kz9AhOi6DuLAMnotK2i
         NnBn7Ff7ZkaCCJ65tDDqGxbCUfAgOeAVYWkdYu/bBtp9F6DgGLtslx0YVyC5Xw8/FCyn
         Q0u2Iwuo5AV//8ifzNxkMIw6O0MWaspuM7crPLqiSJdSJXRXfw/xSqe/YBbBY0fQsR46
         PF2A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787939918; x=1788544718; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R2koS2vCzM8w7VNNntAyqh354TzQoKL9/yGNgBa5fxE=;
        b=oX1+XCds6WNJFNVmtf3a/7uI+DzmlN6pYQvhFb2uW0FuvFXALrqOxobaB/f60BzP1C
         61Tx4u4dLbAcchUXIFenCg5r1zIA6+EAGNNv8E5qfxpIV/WiSHU6z/+C1KwqE79ySRp9
         KYu9fRusWNe1/E7MDv+CY7xEE98SWBMKLKQBMRUKUKUH5gCg/CDVE/4qsgNUirrqoumG
         VLPP8LXnDD/h5EBrLhepY6y4iZS29kqMiheBpRkw9Zu6coALR3wspobYyfZfilu/dwmP
         drb2vaVK/Qes+gDyXLO1+K8GasxMGQfJYGP7VDYFusr04ypDgAGILqYk823pN9DdZ8MZ
         4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939918; x=1788544718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2koS2vCzM8w7VNNntAyqh354TzQoKL9/yGNgBa5fxE=;
        b=FIuSVMSb4kdccntdCwZBTXfmyy0aoLOQRNyYW60R09psGwSMfASWSsTOYOz8WZpkVI
         z1lC/iiNRfocAA4kUWOIbNTmBMJfwMYXQmDc0zc2xBAgTt0KKGyx7iB/udtfwY/x6yqq
         kKQLR/0gQ2Eao8B+k8J2HPnSEG35LV3BV3EPYnDbwP5wBmjRVEYkxicJdtG55qQGFdfB
         yw6sbIjAV6jJG4FJTRo0bhrnZoWMH4pB8+9Rl7YwhEugE/oW6DKuT4DM+sxuUsSGMGWT
         mZCTl1eV+tK127kmGwhJJklcdGHL0gOh1YwDKQE98LgKe/52kH61h878549IpBWqUvI4
         B58A==
X-Forwarded-Encrypted: i=1; AHgh+RpETH/omDNCnYTwQwszdpDBx0Oz6Wzo2T+GtbmfE+ZDEgHcb4DAdm6kA95nqXL6uulNWPv++R+Lhz0sskdELg==@lists.linux.dev
X-Gm-Message-State: AFuF++m/WkeurYbBIsKzH8DKh7Zxb3IfZwjFbccJY0801rhDvHDs2Awx
	0Pt6Q/MtfMSCnEg3ITDkpx7/f+YjHUaQG4YWnF18v6Y1h/Nr+Kf+MHlvWitDzBC10DkwwkJcA+e
	Z93T2mtGAfJffuIBmeq/meIfzoXiNzRqtjmpLPiJS
X-Gm-Gg: AR+sD12am7qT6t7oa+k+HVU2EKnJDIP7Q4cBQdxqjQNw6hwdZLWV3D3xMRMccH+rY/T
	wmDkVwKDlQPn7Ay8N/gBiZjbly3sSRflZ5yovPha055cyqPwwwVlrUiythPHS8yFGq2RuJG8Qr3
	/iPHjDim/pxEzV+xcWoQSY5GTVyB9ouQ9NZ/LUMWuswdufy6pATbHOyIJ382gi7FZE8LCfhqkac
	3GR84Ubv/LaRjP92JftpXal7SE7RdUB1lqQ8dstpvg1cjlI3CMPLJV1WHjAb6n7QAawumbu2V32
	uMcp+/IK1ZrO/sDX/h1e90hl2/xy6XniE6Y8Juh0LyAT2noQRvWw3gPSwe+ZlQGLYRfcVXAa8XE
	=
X-Received: by 2002:a05:600c:6051:b0:499:c46c:addc with SMTP id
 5b1f17b1804b1-49ccbb107damr76865e9.2.1787939917426; Fri, 28 Aug 2026 10:58:37
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com> <20260828124758.GP687043@noisy.programming.kicks-ass.net>
In-Reply-To: <20260828124758.GP687043@noisy.programming.kicks-ass.net>
From: David Stevens <stevensd@google.com>
Date: Fri, 28 Aug 2026 10:58:25 -0700
X-Gm-Features: AcwNN1WqLTUUK7Ta5eHOzidgwYbjtzO211AQh82X2UkIHuKv6OJYSJ2tvHu1D2I
Message-ID: <CAOiLmNGr385FOvdd9utJ6VYmngvRPbg8v6KfVVhFwmQ4oxhLSg@mail.gmail.com>
Subject: Re: [RFC 00/10] Reclaimable kernel stacks
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
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, jstultz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 5:48=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 27, 2026 at 04:29:38PM -0700, David Stevens wrote:
>
> > On Android, system processes typically have 2000-3000 threads. App
> > processes add 1000s more threads on top of this.
>
> WTF ?!? Why does that all spawn *that* many threads? Perhaps work on
> reducing that some?

I agree that the number of threads is rather excessive, and reducing
it in userspace is an ongoing effort. However, given Android's use of
Java and its heavily multi-process architecture, especially once apps
are involved, there are limits to how much the thread count can
realistically be reduced. And even if a 50% reduction in thread count
were somehow achieved, kernel stacks would still consume upwards of 1%
of system RAM on lower spec devices with 4GB of memory.

> > Tracking blocked state and when it is safe to reclaim a stack is done
> > via a series of hooks in the scheduler. The actual reclaim of stacks is
> > done asynchronously in a shrinker.
> >
> > Once a task's stack has been reclaimed, it cannot be rescheduled until
> > its stack is repopulated. Although there can be a repopulation fast pat=
h
> > within the scheduler, reliably allocating memory to repopulate the stac=
k
> > requires a fallback path that defers the repopulation and wakeup to a
> > workqueue context that can use GFP_KERNEL.
>
> I am really confused. On the one hand you have John working on proxy
> execution, with the aim on reducing latencies, and then here you are,
> posting something that will introduce basically unbound latencies.

The two projects aren't contradictory because they deal with different
types of latency.

Proxy execution aims to solve latency introduced by priority inversion
between background tasks and foreground tasks. This can happen at
basically any point if you get unlucky, resulting in unpredictable
latency spikes in high priority tasks.

The latency introduced by reclaimable stacks isn't substantially
different from the latency from refaulting evicted anon or file pages.
It's a tradeoff between the reduced cost of cold memory and the
increased latency when re-accessing that cold memory - clearly a
tradeoff that Linux already makes. In situations where reclaimed
stacks introduce latency, there will almost certainly already be extra
latency incurred from refaulting userspace pages. I don't yet have
production data, but the testing I've done so far doesn't show any
measurable negative impact on user visible latency metrics.

-David
