Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB92AD0F
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Feb 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102434; cv=none; b=EJTfIqe0EKOOe5UNf3gNZX5KjwsK1IDlb4HbNR8LMzruPdOjIJTFjQIQEnC4iRnV5KfJJAjo1z9XhxMggaPLDceKEW21inZtbBqZLnuIrucKtXxdVZVjCdoMPdtUxmxVJqWt1NpmnXI8yu4V7CUMVAXKgUcs4DQ5B+v/0aQOKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102434; c=relaxed/simple;
	bh=AxP4mDhXQ6eQLbNXshX2q5bR/60iXZdBH6WA2FW2R1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdQmImEfSkeBXMH/aOAYU1HANmHLF9eR8P4M04KzzmM70Q71tHkD88BNxuMpWy3kalk0D5TB20GZ72UsyfxnEjNLOoQvn+oysTRHHIiLhHA5v9SBloR9Vu6YnfTy9Osu/GLkfDCwRcyJm7w+rWX1ajOchKVkR7lgdxE5SKRfHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRVjlkZL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRVjlkZL"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-472098e6e75so85551cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 17:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740102432; x=1740707232; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxP4mDhXQ6eQLbNXshX2q5bR/60iXZdBH6WA2FW2R1E=;
        b=sRVjlkZLxRO+Syd8UHuUatc3ZBGhhZeV4OFIA0kMnojLThs+PkvABH3BzSZv9r7Yj+
         nV8hnYyr6zMCmFc6F6SEzhaCFtWU7WSLMGPvuPWfNRfVz7S/CXR0egKMXs1E8jeAExSV
         wd1xJbM/Y2UtITjeCHebKz7By176QNMYQSi+hhg2dZiPRAaTn95hFbb/trBB9MAWrD1K
         ZihCebIE59VUsutaIyzc1j7nGSW8bLTwCDA34WNH316Um/yP4gxDOOOf2GJOQA6r6uoX
         ctrCcYl8Vl3gTNs9JknvB+B1MJ2Evvvd3ERmgTY+fbawv0r7v4I223m73ufSio9XtPna
         tS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740102432; x=1740707232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxP4mDhXQ6eQLbNXshX2q5bR/60iXZdBH6WA2FW2R1E=;
        b=cCJLibjKYzmhLk3iL0x15MHfdqVMLU9leT3nagZIcAurT9Uuq12HErH7Lk5lTD1mi5
         rCWNAQrMoV9pgqttSPb9x8btv9UZgsPCg1JKBTFNs46VfImA/VpEZ/f00RmTnxgXGBXq
         YmGZaVZIlyqbqywrVloFX4kRAd9Eu3JnFQkoK4Gc5Q0rFZ7czy3oyyTLZyLJkMMMUBn/
         bUCE4j2GJqobRB0MxTNNlP2KEUaXfa1lp4cpOVipX9FGBTDL8VGYnx/hus8UfJvQb2hR
         l3V8Kmd/2+vW76hLr1NUDDRDorcV+LmIE58KruNeGUpDYxihj/AUVupjt8PJKm71//Mb
         Zj9g==
X-Forwarded-Encrypted: i=1; AJvYcCXVYYgqJLgY1/fJXr5IlEfm2ChImsHk+OtZ+NSNJTUrTp0eszq/ekmmJ3NSSgTh0l9Eeze2wjUEPuZzzMRwSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRorz1yO23zTFah7CqaysleyJeryyKvNNvYg++DVbRga/XAWHA
	ldSK9/0eNddm6ZHlFSFWJk6Qc2s2F73X17vItgENy3ozc2FNoJgPtle+g/0c3h7GmfATWk+XS05
	xMpUlQq4p1nc4Ot4nV47Wr7RKv0XVP1CCtEO/
X-Gm-Gg: ASbGncshhLULWeZVu50WDUH9UA8cPf184jBJHvdXwD1r86Gs9aovZgs2hhEDQVyiCUN
	bbBBhVa0hH3uiv15ardcg/Wgw4kVmG09hAT+V/UTNR+U/zygFk3bbchb1oD6k6rMViHKi2BScK/
	OhM3dBYRyb
X-Google-Smtp-Source: AGHT+IF771EPpHVaPndwMZB6cwQRtnKdAJc5IswuEkn4dCv7rTHZtXiV/I4ftzRKDItiiUhIX6hiqTMbelJFcmlHw94=
X-Received: by 2002:ac8:7d4c:0:b0:46e:2561:e8a9 with SMTP id
 d75a77b69052e-4722374c0cbmr1803021cf.2.1740102432029; Thu, 20 Feb 2025
 17:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220093257.9380-1-kprateek.nayak@amd.com> <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com> <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Josh Don <joshdon@google.com>
Date: Thu, 20 Feb 2025 17:47:00 -0800
X-Gm-Features: AWEUYZmsiOapix8_7R9IjhNGiB94oqz3kpsgk9TTlDu-2fIKI3PlXsj4YcPwTgs
Message-ID: <CABk29NsCqkOVXHfu1=ir9nhKiy2PVsONdZm29qXdbJX8LrfCNA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
To: Valentin Schneider <vschneid@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Ben Segall <bsegall@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, 
	Petr Mladek <pmladek@suse.com>, Qais Yousef <qyousef@layalina.io>, 
	"Paul E. McKenney" <paulmck@kernel.org>, David Vernet <dvernet@meta.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:40=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
...
> As pointed by Ben in [1], the issue with the per-task approach is the
> scalability of the unthrottle. You have the rq lock held and you
> potentially end up unthrottling a deep cgroup hierarchy, putting each
> individual task back on its cfs_rq.
>
> I can't find my notes on that in a hurry, but my idea with that for a nex=
t
> version was to periodically release the rq lock as we go up the cgroup
> hierarchy during unthrottle - the idea being that we can mess with part o=
f
> hierarchy, and as long as that part isn't connected to the rest (i.e. it'=
s
> not enqueued, like we currently do for CFS throttling), "it should be
> safe".

Can you elaborate a bit more? Even if we periodically release the
lock, we're still spending quite a long time in non-preemptible kernel
context, and unthrottle is also driven by an hrtimer. So we can still
do quite a lot of damage depending on how long the whole loop takes.
