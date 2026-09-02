Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84A3ED5B2
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Sep 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342533; cv=pass; b=Q8qsN2GacpPCyJIFIHLTwkGH4ykfUD5e/xdstd+AZ7ysIn5RyTjqa4a5P3SAnDjY/9u4w+M0OOskqaeh1N22V8H4mVVI2wZbrsbcdnAfzlMaieZYISx221yjuki7DJgCjJqZ5ja1eodcKK6G++rgr/XF48Qrek5h/Y9wOTE5znE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342533; c=relaxed/simple;
	bh=DAYHtINMjyhnTJWyt2w2Ud93jjGFrdXSb4FUKYQtEYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLc93rphHFRMG/YMuRyvOhJ+mXV2vONGNV6IU6o5FYfIVu4q/gyXBLp2QsxM1z8BCgB0zwmned80UbJgA6t05b0Cda7NRoNJr2vOF0LHaoJdD7AK5I/BtSrtTOY2fPZ1MJKioVzEtBg9iSACzis1ml9XOfUxTxdLiqyDXdWv6DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHqrjQFk; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHqrjQFk"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7c1176317so722994a12.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 02 Sep 2026 02:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788342531; cv=none;
        d=google.com; s=arc-20260327;
        b=VaixYLgLM1cQkEYBCgJGRrBPLyqYDMM/7+3vrQM7C1fgMzpaTFJmfK+ulifLiK30/r
         1aPZaYYOhCej+pvSCW/7vflmbMZphA7RaGnM+/UjIoOg3Tyq4VOuRyEzn1pUW+Rj10jQ
         xpRen4hjktJ9RZDLwSsC6esBLWivKfaYyovk7+0z1e1aIKl+2nu5OjDYL33mMpMN+roy
         6/4XT1M/A5gKMzMGSjrwEHo8wXloY0aaosAH3Zof36dkAxRZi40ionb4vOKl2O1s6HjK
         Y/3MTIGqwbDBXLRSNSAVulNL587DFHNIGSduHo+W7KDYBdWgJ58QINAGGC6F8IJkiPVj
         eUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAYHtINMjyhnTJWyt2w2Ud93jjGFrdXSb4FUKYQtEYY=;
        fh=UTjR22ExI6LIbBkoGtACuhjvziXaLMo7uiwnk8ReUXE=;
        b=eWjxznh7yV2MrjHFWCWdHdSo0HGCuNxOYERPen3BKjOwxnxfMdQghZhcE4rUSnT6C7
         cZPKFA4o2OhBnL9Ce78YHvQfMLMr0iXhNoUs2ZgLcEAJFS2hvXqj8/gDb/8GwOANAq3P
         zzYwXWY0f1+zUCWRg1hs2VJw1sYS7D8RhR4qOCKNjalmHxE1nRlvwzH1YFGX02zdzs8P
         QWUvYldL63xsNnNHnprtxU1bql0fI2H/+uuB6L2ttESeOEJGC55S2Qs43QqjWbdo1jHA
         7Ym783umpyyT3XuAPfRWBxA1TAPAoLbBw04cnVP5Sjt0p09vcfJMgWcqmdeBdWLGnJkY
         vgRw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788342531; x=1788947331; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DAYHtINMjyhnTJWyt2w2Ud93jjGFrdXSb4FUKYQtEYY=;
        b=vHqrjQFkkvIahqNouFvBVtTv0sBxdC6Jxp5tXQLZagdO0VEsNy8LblK8Gzpyfm0Aa5
         bOyQOXjhY4lGbpkL8HQtW3kSaM6y1NRZJq7VASlPopyoPga4AjLnync/Pfe9yVd6qDiu
         2HtbG9fXbmEJlv+tA8XrSTF1YpkAeDblofanMoGRRSG6KTpSlCB/m0SrjvS1MpwAmshd
         WQ/dVxK0zchTQ7Im5mkKSDd0FWD0e3WeGINXSrANjtTN4u6EueDx+0drfA5BiDBQLYE2
         lOq0geI4ZbEgAT7+mnFeSodmTAfpKNX5+8UFcewMli8h0uY7/kg3sIeHHK6fAedkIgRo
         exkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342531; x=1788947331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAYHtINMjyhnTJWyt2w2Ud93jjGFrdXSb4FUKYQtEYY=;
        b=icAFlGQSct6XzB3y64eZKGn+R8QPjaqp6CtOTKJvBKkol6G3VfAZoTy3MxGx8uC1kH
         U6H7dYPn+p46C4blCIQIRZCqcR0z9Iw3ZYobdFgRjMBGXE3m4tHoFZ9oUn5u/NK/LJtv
         BgQLMFgUYLLYPZ30T9AlP/2X5NlTHXlVZB6TlXojk1fuM5qEPaXFHxQJ3lpVeJfTaJE/
         LqKTciZ1EkkrY3CNGZI0rjRpKFIVd65+VsW4plmdVByhUrExENL6FWxSI2kergn66OQu
         szVHWs7VOqlU1W9quOWhmGazEszDjlfOv3ruu/pHAxs7+rcjNLUZvG/+mhL2MTTWF35v
         MMpA==
X-Forwarded-Encrypted: i=1; AKwUvBwBSROuDWE5yQMeE5lIgRXf6SZIrq/VrKRLkQfbR2vs0+9LKXOW6BT8zCF0B54sALWId5HXTG5SzZ2I9+2nWg==@lists.linux.dev
X-Gm-Message-State: AFuF++m1T2UPoEhKS600rY1ymliIS0RNWjphf9kYtxNxo7So0rRD0Wvv
	PEZB4eGBrf/pzO/CdgSLnQyR5YBTnHCeaPv42rPJe8aXgtVBFsr0A0jLsFea0mMierVl07qIq7j
	uA6uMzC/nT+2l2ARykqXY4jQDtGz8yxjAcVQXc8bV
X-Gm-Gg: AYBFou3eC0xccJyzE6dDLdgz5YJUZcj16ZIwkMJm3rklcQm8Zd7EzXufaB8frHY6ad1
	veeTe8GPLTbvVZw0s0h4WKocdKLK/Weehc+oNBCFgF+LQTBni0oXfY5RCUBveIQzN7fzclqKeya
	ChzCr11MSc0msJ/LlS2AdDZmUHlBP1Cg3FwH5JjpSvAFFWQ3e6/DWT0IhZQ6vaJFaeoDgU5QDqZ
	7awAftGJSsdbAjJD2/eLFNdlpPOAcATZ6zhqgkfccGE26mjknuNabBoeUzyCouP3h2W5h9mAaTF
	MszAVLDbwPElbckf1W+nB0Iy096Nngd/VtmdSHOp8/Zj0Wo/CHtKfCPEebdAhJ6T+Jhp4uJovA=
	=
X-Received: by 2002:a17:90b:5384:b0:398:ceef:edbd with SMTP id
 98e67ed59e1d1-39aee1bbae0mr5657467a91.18.1788342530162; Wed, 02 Sep 2026
 02:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260811154111.64669-1-kmehltretter@gmail.com> <apZlkC1lCUFFMKsl@gmail.com>
In-Reply-To: <apZlkC1lCUFFMKsl@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 2 Sep 2026 11:48:09 +0200
X-Gm-Features: AcwNN1Wrf69jjm1OyBEhDEDLxC8921rklaSkn1qBn2gou8dtPIrMWnmBuSExKH4
Message-ID: <CAG_fn=VR_mfRpbtzgXU=pO2hV9dzgqdrfSPEG_no+vZmC066QA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kcov: Suppress timer and scheduler coverage leaks
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Bradley Morgan <include@grrlz.net>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 7:50=E2=80=AFAM Karl Mehltretter <kmehltretter@gmail=
.com> wrote:
>
> On Tue, Aug 11, 2026 at 05:41:05PM +0100, Karl Mehltretter wrote:
> >
> > Add a nestable KCOV_PAUSED bit and a kcov_pause guard. Use the guard fo=
r
> > deferred hrtimer rearm, __schedule(), the try_to_wake_up() wakeup body
> > and wake_up_new_task(). This suppresses their instrumented callees
> > without excluding those callees from task-context coverage.
> >
>
> Andrey, Alexander, Dmitry,
>
> Could you please take a look at this series from the KCOV side?

Hi Karl,

>
> It fixes the CONFIG_KCOV_SELFTEST failures covered by this series. Some
> architectures still need further architecture-specific KCOV
> instrumentation exclusions.
>
> The three syzkaller A/B pairs from the cover letter also suggest
> better coverage: at matched execution counts, the patched kernels had
> 14-19% more coverage and 42-54% larger corpora.
>
> Do you think the pause mechanism and the places where it is used make
> sense? Do you want me to continue with a v3?

I think it makes sense, although it would be nice to try to minimize
the number of points where we insert kcov_pause()/kcov_resume()
Perhaps we could piggyback on some common scheduler action (e.g.
locking) to do that?

If Peter is fine with these annotations being open-coded in
kernel/sched/core.c, then I'm also fine.

> I also looked at the Sashiko dashboard report:
>
> https://sashiko.dev/#/patchset/20260811154111.64669-1-kmehltretter@gmail.=
com
>
> I don't think the remaining warning about reordering or removing the
> kcov_mode stores is real for these call sites.

I think consistently using READ_ONCE/WRITE_ONCE here is better.
See my suggestion of converging the flag functions in "kcov: Add a
kcov_pause guard".

> One small change opportunity for v3: In try_to_wake_up(), I would take
> the kcov_pause guard before the preempt guard. Cleanup then runs
> preempt_enable() while KCOV is still paused and resumes KCOV afterwards.

Agreed.

> I would also replace "uninstrumented" with "built without KCOV
> instrumentation" to avoid the ambiguity Peter pointed out.

Ack, this is indeed clearer.

> Separately, I will look at turning Peter's IRQ-exit preempt-count
> proposal into a standalone patch for instrumentation in general,
> especially KCSAN. It does not replace this KCOV series, since it only
> covers work run directly from IRQ exit.

Fixing the IRQ exit should also help with some KMSAN false positives,
so I am all for it.
