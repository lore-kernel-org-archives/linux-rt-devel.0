Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FC20FA86
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518000; cv=none; b=oirxlGMH3/KtPGPNw+HvsKsxEpCcTWJkEalx3ASQFgW4wgIbjeuna7pCEjKceds1JjFxrwz9Lr1Y0olxhVSaLBDP860s1Sz1J8mkzolaTe8AWBeS5CbVuNstF/9qC5Cji0Q9mreKeNpxatf6c5Snrx7yyx1vj8HJqiK/Ft4w/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518000; c=relaxed/simple;
	bh=RGluz43GVvStsDd1HSxx9qZpHwxLnjUMaRjVhtcePjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otekQQLg5/y3/LanRFKsjUx1AgJhNsDRbgvblu86Vq2J6eCyTu1KDjVRw1+ZFVJHy3LD1mSXUfpIS1+Y+bEBZvKsl6kCSZufqsA5y5eNa0bjB560LDC4HwbUfVWf/hp2MIFNrTBDL7dWm2IulMtmbBTuODDgJ/ihbE6LTaPL7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPW9plm8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPW9plm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740517998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGluz43GVvStsDd1HSxx9qZpHwxLnjUMaRjVhtcePjE=;
	b=fPW9plm8D8fMmXMThWrtMKADzOP+/hXNAZ/rebkme61FYsPtpjlr742dYRKsSrdrsahxLQ
	a2p8ngsVt6QahHxeHZEdSsixJGv8OI15wG5d955YQOhsoXef8WPTmNRSI206dLfrpFYTzU
	eh1LVZVstPKpESe9ya/tER7rthsjsjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-u2jePu_OMYm7ehWmnAl6Ow-1; Tue, 25 Feb 2025 16:13:15 -0500
X-MC-Unique: u2jePu_OMYm7ehWmnAl6Ow-1
X-Mimecast-MFC-AGG-ID: u2jePu_OMYm7ehWmnAl6Ow_1740517994
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f31e96292so3861284f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 13:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517994; x=1741122794;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGluz43GVvStsDd1HSxx9qZpHwxLnjUMaRjVhtcePjE=;
        b=eg76eFivtX0FdsYEQaT7snQJPzn78jc9NqZZWUdygm4XulX8tCGnBsllMDXyIgkOob
         MSucL2kJg2ExooaRlojF2ittKjpdU1GLNPI9rSqr0nREz8382PrLWndl+NWbbEIizXGC
         uk3MmgJD0DzXctFMNM9NuRQhwL4vR1b9A5BcXx3S4a0fu1ZNgAxEY4uVKP+9pEx60CK+
         JwFkNEAk+P7jnOqFEO5k9Ie3g241txR2Pw0TnfmfM6c9q+i0fqGPVY/uy7MiL0Fs6fFP
         QONzF0TBxqld91H5ZDEt1zY1ehxEAzhIrRaaSEfmpvm25Rm5S17w75BI11RwQgsDtecy
         hF2w==
X-Forwarded-Encrypted: i=1; AJvYcCVJnWGT8n3wmavm8IivHJSjk8MZ3C66ONMQGUcFKLbuoIbZzGAJ/vPHkI5BTcukfru6R9eQ5MzoXfFEvsZfBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlSyKDtil185AENMgDDVthlaaHrHMc0dR+FlxfhAqllr2z7PTK
	7jPne/8vdh2y0s+SYNs2T7T9bG+swu6e4a09P+Koq3T7pVydOK1nGzjRugAwAdmjrTunYVdhtRP
	n8CCOVBLGjCAVt5tIRVsY0Qpqmha9Loz9XjZtNUvJ6ph2kgHURRG7t4g3GV5v2jpR
X-Gm-Gg: ASbGncsUytNVKXuXuyB9bi99FSGY40BXrszTHuvsXOjt0D4VthAXe65ogDQXFPp6K9d
	F7hSEmLe6rHtViKrFaAvKCjvRxfknbp3m3AzoYFhuSs4nuffLx04hRb1n4Isl97SHoy920/c43Q
	f5avQOs5lSeQS8QAN+5MrG6piUtgJUSZghPexYziYIScWOIPhaZL9PqOX19Y492VaFfh0uIm6sd
	KJitW7ZCvPHnlsAzBLGYHp8Gn1dQ75GZbBE1b+6Drp/O3nozf/nh/ONs6wULqpjFyooWTtOBSfI
	OSeL3iFkY0DFhEh/4p8uqpjW8whogk0HBOrk2XledxnvPnWGoMK1Wu0GX3mrXp4AFRKeay0y6kI
	C
X-Received: by 2002:a05:6000:4013:b0:38d:e584:81ea with SMTP id ffacd0b85a97d-390d4f9fb3emr645235f8f.45.1740517994502;
        Tue, 25 Feb 2025 13:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy4N/He/MCmAygW2he1I9yokRSLZNxxCGRPy/cDMpHs3zYeeaXE6c7lSzjUiEkR5upKQt5iQ==
X-Received: by 2002:a05:6000:4013:b0:38d:e584:81ea with SMTP id ffacd0b85a97d-390d4f9fb3emr645220f8f.45.1740517994160;
        Tue, 25 Feb 2025 13:13:14 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8667d5sm3502299f8f.20.2025.02.25.13.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:13:13 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Don <joshdon@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Ben
 Segall <bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>, Andy
 Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev, Tejun Heo <tj@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, Petr
 Mladek <pmladek@suse.com>, Qais Yousef <qyousef@layalina.io>, "Paul E.
 McKenney" <paulmck@kernel.org>, David Vernet <dvernet@meta.com>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal
 <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
In-Reply-To: <CABk29NsCqkOVXHfu1=ir9nhKiy2PVsONdZm29qXdbJX8LrfCNA@mail.gmail.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>
 <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CABk29NsCqkOVXHfu1=ir9nhKiy2PVsONdZm29qXdbJX8LrfCNA@mail.gmail.com>
Date: Tue, 25 Feb 2025 22:13:12 +0100
Message-ID: <xhsmh1pvl20ev.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o0sTwdaVGLO4b06n6Gunx_PnYJr1cO5MpdsfWAhvRNs_1740517994
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/02/25 17:47, Josh Don wrote:
> On Thu, Feb 20, 2025 at 7:40=E2=80=AFAM Valentin Schneider <vschneid@redh=
at.com> wrote:
> ...
>> As pointed by Ben in [1], the issue with the per-task approach is the
>> scalability of the unthrottle. You have the rq lock held and you
>> potentially end up unthrottling a deep cgroup hierarchy, putting each
>> individual task back on its cfs_rq.
>>
>> I can't find my notes on that in a hurry, but my idea with that for a ne=
xt
>> version was to periodically release the rq lock as we go up the cgroup
>> hierarchy during unthrottle - the idea being that we can mess with part =
of
>> hierarchy, and as long as that part isn't connected to the rest (i.e. it=
's
>> not enqueued, like we currently do for CFS throttling), "it should be
>> safe".
>
> Can you elaborate a bit more? Even if we periodically release the
> lock, we're still spending quite a long time in non-preemptible kernel
> context, and unthrottle is also driven by an hrtimer. So we can still
> do quite a lot of damage depending on how long the whole loop takes.

Indeed, this only gives the rq lock a breather, but it doesn't help with
preempt / irq off.

