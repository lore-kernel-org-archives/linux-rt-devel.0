Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC73F12D8
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396994; cv=pass; b=qojkce3I62uakj6nWHlYbe/+bY6UCWuqGQvs4gMK3qazx8NGLsWo+p34LA4miVYtycURLURIn47VPtaw/wQZkOHdxSvOyra7Qz3V0FWmR4iodqseHaL7IZ2uU6bYoTRrxC/dGzFC80N9aLhVS/rS6JkRf4BLOPIiWwpsRPoTMuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396994; c=relaxed/simple;
	bh=HVlxiLUTNiWE+bPAoyNB60lJPdl4a+s1ny2DsDgGaHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkkSpdxFCC81f5RMUr9h1+OvnHGbpuR269xu+M42S36cPYoWbl53kExd0NkbtKZKzGm8KHKg1wArqJkTfg90L3XmH8FTk1ZVSLZ1l43cTNNjGcm4regqcU+SyL6YlGa78CmkCmN9/f5iFYWB17B+XNnMLLkY2EF1EmAz5cg9Bpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0BAUsrC; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0BAUsrC"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso2139922a91.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 07:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789396992; cv=none;
        d=google.com; s=arc-20260327;
        b=ZZVNim+76Gg6ltg6b2i+YniZ/PMutsPjJHWgU+Eo0PNSFsLOIP+QvpRKYcthTD0Qmh
         cRYr+rS+6pvvoLgL055dgexPmiknHu4f9qotqge+XgEA5WIb1nrCANovFa1I+mWLL5DZ
         6dH5USrS9ys+4abhshCtc526jrLzeMM7DOKwRV+p+y5B+VFknF4oTJN/hVMUUsxR7d5F
         v8p3on58Zmkmns02FmMDoni8Wke+A3ugRKPaUwcld2TaqRXfqb++lyiTzoQttXgqe8ME
         ONNtNleYza+Ue1hUjucgGlsduWvghwcVIRj1BkpORPVUfMGwnmvsye7ANEG4F19KNnvI
         9hdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LH9xqDwg+UWNhqzaDxSdBTBsbVKqSIk4FBsXYbZlywo=;
        fh=B0Bsf10rqkG7kkgsR8NmBxHZOiKLzSg8KSNK//qbznE=;
        b=LwlgscFkN5t+C1vVfZqUXowpggL5E1NML0m6f7U3pDBri1LI8VG2B82zNAbAAef4Tk
         GvvBcYOsOyqd4cy/uCCxhD6LbXdWSgnMgKU7qV3rtr/g/6S2yMzqAihnAsR6l8fuOWuI
         yrlCprWDoOCF6snVE7FAzSUpORFzA1XgdZ81wAAYgcc1/ZrbLIqremvplrXNdZbpTeh3
         3OrgvIVoNbx2fwucDO0oDZuRauRNDD3pxqufBF5dQphsQSOXD6vdziN5V1rpmdZuWoc1
         OuzB1Hk+FTkDcOqd6uZnAPvNvQNjjl5/dfGxo+L2OHx8IlvFbcjq2SlLfYuEF9y4ABZD
         B67Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789396992; x=1790001792; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LH9xqDwg+UWNhqzaDxSdBTBsbVKqSIk4FBsXYbZlywo=;
        b=I0BAUsrCKQKgMj2j2evqk1U9rgBGDAUM6roYbTtXycoNyOevHQtTrWR403LTwHtbTM
         DzXRLgPC8tMx6W1jmPGxVYfV9pRTz/XBmYCRP6sCwv5finBRcGgaUgd1plHbn9hdu0s5
         qL7N4o/xZDXuEcYKYGrVXTE/Hc4lxsp3KSEIQ5xlzFDnu34oHDKgXsVWitWws0vnI4p9
         4KjFTGz79mtZEPiKPxwv3gFqm2HOVtJaEl5hOUJ97KtDzmwwkigpeCs5NAac4Pa4hw6M
         qdV1+vk3s3EAIYAJyDUlfeRScxrllWp+KcSEGC2iHvin70XGTBI3+tbrcqev1MND+ql3
         tTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396992; x=1790001792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LH9xqDwg+UWNhqzaDxSdBTBsbVKqSIk4FBsXYbZlywo=;
        b=AC0+CHKODOeRgC6BncooqazvHWY/pnZ1QltZ+YxIBujKVorGDCsfbJ2DPqPrZBZs4o
         0VDtVOjPMiOBVL/iMMpZU/OTyazMuC2eMdBczdRJ/wY0ingJe0nJ515gT7t2RIIZkT5Y
         ZZZVOmVmfbGfy0wixrTEPzk/WXxoBUeMIKTUHLqLKWKmW9L/I2jrFkhbJi4VTkXKwDlF
         fOS9Cfds17EPZpBTlciz0MD86uvSZBOqbkJ1YLYli4XWFfMaz1IYLfG4JAk7jG+mv1Pu
         tr4CcvizCgmItInNQxH5/P63Mj2XIOeJOzDpA5I2OIpsT+gQZLslFGl71/vNpoi8xp3l
         TqhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRf6javc66C7QAnhDgtuSOOzs61h45Ijp5DSzF0UQe/riLUqvp5kVNb9jf7LsAIA/hFyuBTJ2SnASUQw6rFQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mePHWA+sudll2EVQ9j6425QpzKBxxESWLFwSYLQkoPq4+YWIjp
	sOyfeCJnsPrFBIwZgovmZPzFsFsnbJIJ/2TK/RzXsNQgvLdkFkM7lx38gX2671NVWMIO0e2FoCS
	w52ZSHWNWt38KQTMGEyyF5LXbbwYTURDDTid7sNE7
X-Gm-Gg: AYBFou3U0iQpKZBismryPCledD2xo7T0PXNFUJFyUQ5vLVoNVUDdR6HjlqaO82Gp8/o
	hFahyYy9HHf8Xw/2AdTyOHbVN7dL7RyRUvmg31G4CE7vm3ygLlIwAZ4EVxck745jRwpTZi71baE
	BEPiWzZi2PRZfOKmrDUEgQO73F+9AlfVee5GdhzgAH0Am9TpLK/4HzbXJaBrT0+ouSkvdafUYhZ
	/vcsz8UqZf/FQbxRrJNDGBBYx4TlTCQlWFo8JsQS+r+Od7Gl0btlTuh1fwAbL3Lq0gHeQm4jw3J
	yVQglum4JPRt6AaWgeQv/w/gF4/geHBwZvT0KFKTO0r6Z34DZCk0cY4DP0Tc00j/lmLEywIYlHp
	/J65NGh4K//Bu
X-Received: by 2002:a17:90b:4b81:b0:39d:f95d:bd08 with SMTP id
 98e67ed59e1d1-39df95dc372mr1658544a91.14.1789396991179; Mon, 14 Sep 2026
 07:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260914054632.12877-1-kmehltretter@gmail.com> <20260914054632.12877-5-kmehltretter@gmail.com>
In-Reply-To: <20260914054632.12877-5-kmehltretter@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 14 Sep 2026 16:42:33 +0200
X-Gm-Features: AcwNN1WppAUKdCf37pS7DpvK-X6wLcpPx-Q57kOJ1aEJoSJxBHs5p6fSfydB6Xo
Message-ID: <CAG_fn=VwN-1pdK_3=qrwpDb=EsyOdoNgNK19zB7Ga0puQZgScw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] sched/core: Pause KCOV in __schedule()
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

On Mon, Sep 14, 2026 at 7:48=E2=80=AFAM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> kernel/sched/ is built without KCOV instrumentation, but callees such
> as sched_clock(), architecture CPU-capacity helpers and profile_hits() ar=
e.
>
> During preemption and schedule() calls, instrumented callees can add
> nondeterministic scheduler coverage to current.
>
> With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
> selftest fails under QEMU, detecting spurious coverage in
> arch_scale_cpu_capacity().
>
> Annotating each callee would spread exclusions across architectures.
> Pause across __schedule() instead, extending the scheduler exclusion to
> its callees.
>
> KCOV_PAUSED remains set while a task is switched out. The guard in its
> resumed __schedule() frame restores the prior state.
>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ae97c63842a4..54b5c5383fe6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7116,6 +7116,9 @@ static void __sched notrace __schedule(int sched_mo=
de)
>         struct rq *rq;
>         int cpu;
>
> +       /* Instrumented callees would leak coverage into current. */

Here and in other patches, I believe Peter expected different wording.
How about "Callees instrumented with KCOV"?



> +       guard(kcov_pause)();
> +
>         /* Trace preemptions consistently with task switches */
>         trace_sched_entry_tp(sched_mode =3D=3D SM_PREEMPT);
>
> --
> 2.53.0
>


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
