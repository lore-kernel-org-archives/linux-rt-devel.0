Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73833EB1B
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272610; cv=pass; b=UXLlonPStNNP+QIgz/69GWVUrkYT9kWMy1tEdYYj/jGltbnARRHpWdBviyXqKU7R79AbH1rQXmL6KkLbaQjP0DU24ZJKuE9moZJCe7HZmGV8aHmyNL8NmAk18fvzV3Uu586zlVekMlyTbyf+tXv78cf5sPrbAAxLCApgNVD/j4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272610; c=relaxed/simple;
	bh=qVZFdLEELdtpeRS48YE/BFx4PZCoxsypLGymnPxXdSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5wWIKti87aehO9m1G1gOq60y67oGHbh+lNpC1ZtiCE4f0FQwBzit9U2Sr2zR6PaDTQcmd9y0Eom5NrakLZMKuEYVZF9i3uxBl3McibfI6+0DOHoowqoaluIs2wSP6WCWW0uMPHDExJTaPXokcoF/ZodekHjHi2+tvF2gwvoR1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMfV642m; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMfV642m"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-396750cfee6so3876575a91.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 01 Sep 2026 07:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788272608; cv=none;
        d=google.com; s=arc-20260327;
        b=a15m2zEIgLnoY9FnqfZH+DWqtxqONMEtwKXZUCfIyfF9TKq9K4nDxms+2e9Os9jPt5
         DtLMoEiIlLAWVIui6cftZdEstC67BkK79YRHam8V91+Wf44Cg9KcoaYI+NJTOmsG7fcw
         Bm08Cv4/W0ywg1htiNlqLB0tJ3gLXZvQXDLLn7oab24KfQL/6MWXvJbbIvi4DZ8uTCnS
         zD1k3lxOiaCIOdYdRfmI8dO2T/t8yw7pNqDkrzuZGOYqbKblj0xwPNkmwVeo06KAYVxh
         w4kK2Y6QN5Bf6JruVUi4TcP/GosmXummhF/lXB3leI2bQcAagZ78l6pyCm5hxwm8gtjP
         QGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRvC0bVDQMbTYiwzOOlxphxSOpTPx7t/v7axgahVkgU=;
        fh=XfIsMvgfA3rvXCySpCt2nK1If2S/hfJqUKXSC1Lh1+c=;
        b=iYw/vkTGBvqzdTl+Ka3F8cvuhR8jU5JljpkFX9ZBNh6HvIbYOsuu3uGKfVRaATMbhv
         zJsAhkSTJMu4fMHAowh4BUX+jnbyZHQ5C2ot/+MD7PW0vV8u3jqzSriHj4xX5hP29fTc
         PD51tTjzfYTZ3gWawHqIQoMXWRVxE24TUSG+RkAOzBbIuDf6wlSqTsdkqi5WH20aPfwZ
         ejzzfQ3SFyNqp+LV9WrU2OxpN551z101AQGk5yUblEA58cH0jmTGdOc9+FTdNRzr3V8B
         y5L/MqoST/GOUdO1T12L4UUgE8DBsyKQVeLdBiVDkdaHIEk8MoElOXc7Ur7FtvVz611B
         1aUg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788272608; x=1788877408; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yRvC0bVDQMbTYiwzOOlxphxSOpTPx7t/v7axgahVkgU=;
        b=mMfV642mBhODDzSro1uz25n9//qEAcxwNnchN1YOJ2uLIJZ8pLGdwTKdsB9GB7Yjxd
         pPUuuIxak9cFYJULbIFegscVYHM/Lev66LdmeySBqNsps6qpdg5YZbSLREvDIUjYL4/G
         ZjhNNOJXaPnpI2LrOe/P4ymSvFEgEHxDTrxPjmsRL3S0RWxU6g8E3Bjps5hIT+zdk3+R
         YPnuK/2zHG0AYNRL4KkgLcHDJx1Tw2uBFkJgT2Q1H25JOVnxSk05YRcb3faB6yEzPSVb
         5nPfZxb/9qF2l4sMmsEL83jIVdVLq+dj+c+kvZQC44NO7fNnlmoGQZOmxcT3TJf422PP
         Iatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272608; x=1788877408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRvC0bVDQMbTYiwzOOlxphxSOpTPx7t/v7axgahVkgU=;
        b=P0yS8U1hAOi6l6LfH2ZXuMj6aYwaI0sHskrV2390LU49i0Bw8uWsaZsON2cvjdCBm8
         VZ5w6Q/Fma2WN1bQg5jBo0OhUOzLDtgXN+wRO7gsHIW+6vsVxLY0k46as+RNhG4oHuCC
         avsMpBF+ymbjo2X/TC9QsPBRWfY0rJTJAUiDPR20nF4GQQ+F674WlNcksvR4S3O7l1BI
         5M1W94sG6B/51k/Eayx2MkGsGZJl4I+YL8C2t8G96i1LU61nnAnSGNGyGTvceQZsb7P6
         jkiryoxP4GWi+wakZUIpL0Qh/PN6nLyceZXaVhO9/JcTE8DNqrYRZo35yBv70wqD4stc
         yK6A==
X-Forwarded-Encrypted: i=1; AKwUvBzGOHin6y8HHxcr1faDlR3rhwWIc/XVNC0QoD/Qlp8W9/ThFrdVYHIITYHfxase4bqoeztuArdQ6xmmUiSS6w==@lists.linux.dev
X-Gm-Message-State: AFuF++lwepc/FpN8VUdE0NYKz7fU5Q9iijoN5OGYmWdJp4Rpdo0Ussfn
	iPQ/yQ3/53dt9WinGy6G6ZDVsOfC2/K+wJQc1ULWljLlZqZz8lBtjA2uXjmj2L34Sf53k69Dnyq
	HQSFb3mojKP/97SdUYUzrGd8KIcqY3k3csuqT/0Rc
X-Gm-Gg: AYBFou3+sNn7malsNcosz6kJtdwQ9BQpWX6a0/16Cekpyh05GkNKv6aDVfJcM+HTB/3
	Td5SipFgDfuA0jkT/f6Gyr6pqNPliYymZgXwUdhv18NcENAUKhGWMIr4Qavi/+2k1XQxyRrhFhy
	fsR5V0pTdqDrHR0xGcYmxZ7/vOXIHcTZUNUkViaPOWBq8Zg+r7+c8RM1McsMhEa/4HV87XFXR4+
	QP3kzYwn+JRGcES6MK2A8PhheH23XEJPxgOy1c8/LVEmbxHfLgIfiwuHmnkVsYlxxitmdxWd3nZ
	KYjiX/STOyv53cd6edys+VeHnyyAgD8CNx7PRQcFo4UCx6LNGTH/F1X9wSM9CBLA7G6FOjjqH1o
	=
X-Received: by 2002:a17:90b:57c8:b0:398:9bd5:4910 with SMTP id
 98e67ed59e1d1-3989bd54c5cmr37828396a91.23.1788272607558; Tue, 01 Sep 2026
 07:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260811154111.64669-1-kmehltretter@gmail.com> <20260811154111.64669-3-kmehltretter@gmail.com>
In-Reply-To: <20260811154111.64669-3-kmehltretter@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 1 Sep 2026 16:22:50 +0200
X-Gm-Features: AcwNN1UXW0GHI7VlHiZv422mZOWzTkl7pcwphIX2rF2RlL5p8DQ9JNZqMFJaNIM
Message-ID: <CAG_fn=VcbA73TTxP83kgid2VUj1atf+6ZBU-NaKUHe=3vPzfYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] kcov: Add a kcov_pause guard
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

On Tue, Aug 11, 2026 at 5:41=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> Interrupt-return work can run after HARDIRQ_OFFSET is dropped, when
> in_task() is true. KCOV then attributes instrumented callees to the
> interrupted task.
>
> Add a KCOV_PAUSED bit next to KCOV_IN_CTXSW and mask both in
> kcov_mode_enabled(). The coverage callbacks need no new check because
> check_kcov_mode()'s exact comparison rejects modes with KCOV_PAUSED set.
>
> The context switch suppression keeps its own bit: kcov_prepare_switch()
> runs on the previous task and kcov_finish_switch() on the one switched
> in, so its lifetime is not a pause section.
>
> Provide a kcov_pause guard backed by internal helpers that operate on
> current. The guard saves the previous pause state and restores it at
> scope exit, so sections nest. When KCOV is enabled for current, remote
> softirq sections save and restore the complete mode, preserving the pause
> state.
>
> The helpers are __always_inline, and guard users must be uninstrumented:
> inlining does not remove the caller's own coverage callbacks.
>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Notes:
>     v2:
>      - add guard(kcov_pause)() backed by private current-only helpers
>
>  include/linux/kcov.h | 40 +++++++++++++++++++++++++++++++++++++++-
>  kernel/kcov.c        |  2 +-
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 895b761b2db15..1b4806dab62fb 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_KCOV_H
>  #define _LINUX_KCOV_H
>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/sched.h>
>  #include <uapi/linux/kcov.h>
>
> @@ -23,7 +25,8 @@ enum kcov_mode {
>         KCOV_MODE_TRACE_CMP =3D 3,
>  };
>
> -#define KCOV_IN_CTXSW  (1 << 30)
> +#define KCOV_IN_CTXSW  BIT(30)
> +#define KCOV_PAUSED    BIT(29)
>
>  void kcov_task_init(struct task_struct *t);
>  void kcov_task_exit(struct task_struct *t);
> @@ -38,6 +41,25 @@ do {                                         \
>         (t)->kcov_mode &=3D ~KCOV_IN_CTXSW;       \
>  } while (0)
>
> +/*
> + * Pause coverage for current. Callers must be uninstrumented.
> + * Pass the returned state to __kcov_resume().
> + */
> +static __always_inline unsigned int __kcov_pause(void)
> +{
> +       unsigned int paused;
> +
> +       paused =3D current->kcov_mode & KCOV_PAUSED;
> +       current->kcov_mode |=3D KCOV_PAUSED;
> +       return paused;

I think these two function can be consolidated with
kcov_prepare_switch()/kcov_finish_switch():

static __always_inline unsigned int __kcov_set_flag(struct task_struct
*t, unsigned int flag)
{
    unsigned int mode =3D READ_ONCE(t->kcov_mode);
    unsigned int prev_flag =3D mode & flag;
    if (!prev_flag && kcov_mode_enabled(mode)) {
        WRITE_ONCE(t->kcov_mode, mode | flag);
        barrier();
    }
    return prev_flag;
}

#define kcov_prepare_switch(t) __kcov_set_flag((t), KCOV_IN_CTXSW)

static __always_inline unsigned int __kcov_pause(void)
{
    return __kcov_set_flag(current, KCOV_PAUSED);
}

(note the READ_ONCE()/WRITE_ONCE() around kcov_mode, plus the compiler barr=
ier).
