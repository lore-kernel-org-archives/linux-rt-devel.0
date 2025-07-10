Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CC2EFD84
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Jul 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164363; cv=none; b=bQJCrxpblnfowBXFB5/EnPCeE/IsfNPrmnuBIv26wcIUPKUjF3NJFTnLR+U66oaG4qKzJ4viUBhETIBziuw6idvJgNaWUC9HvQO+DzMOXQUeqETdHrkzFxVgA5k98qZQ3xWIVG11qREnkMSt/pcV1Ylw9uYOWb9it0c6fkskd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164363; c=relaxed/simple;
	bh=YmAxF8TR1lUnIWjvJfSysEiQVexi9iMpay8Rx18dvyA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GEaNkns/M6GJGOjF2lZBI5eTXAwmjph12qZtyByQLnUmb9urTcj3YLmh/YXNo2oikUN7onFv7/2LGopDjpDhbWAAaUT7pkY6vwtQAJl79H9ybVTMtWf8nm5NvtH3XXJWvflLnJJaXt+rcDpkMt8EwsXCAZ6TRdNbISxInC0dgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaOpZnDz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaOpZnDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752164361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jb8MxRFJ7YDicHzCqkcmOzetiDqrKlL6YyrmCbXyEbA=;
	b=WaOpZnDzWtKom+sCLNhNCe6GCXMVLv7ZoHQV7LMav3abdDEfOTmhX07ncrizCXNT/6bayz
	0gRytNMyS0tNosFEcz9giACvQjqvTgoke0qf+vZD/nvwAV9XGPXd+svYeQf5BI5aTHlDt+
	dVMIpmj94yC+89L3cKDPoMcn0087VEA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-iHETUA2NNEygaTZKEGTDXA-1; Thu, 10 Jul 2025 12:19:18 -0400
X-MC-Unique: iHETUA2NNEygaTZKEGTDXA-1
X-Mimecast-MFC-AGG-ID: iHETUA2NNEygaTZKEGTDXA_1752164357
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso842925f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 10 Jul 2025 09:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164357; x=1752769157;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb8MxRFJ7YDicHzCqkcmOzetiDqrKlL6YyrmCbXyEbA=;
        b=kE+Ta/6sOcQIJUSIGZUxz7r6Y2H5vRF0LB/kgcAr0tqMHdzJwOQq6ZqIJQSIWGs+MI
         JUCnk4bHjB2sU5Q8uAARtMJ6ASvgO20FaRUvsuwJwa6Z/sFBd6OQ3QjNfC9v9K0BluFE
         MhyZk3f2i5SOCJHeTJpp6FJmtwIC4DSrFotPESSZC5atq2nhfaZaiw+7uwgPHQ4N0pnN
         KXvxrpiOd5V338I3lP0WQ6MUThNHy5k7/SRObDTPVpinNGoeZsRdcwzpQR27xNcmV5Dr
         85eboEdIdldGPT7EvO6b2Kcc6VBVwYjtAnLtF0TI7wYGu7Hv63Szp7SgYpFBaCL8JihS
         Rauw==
X-Forwarded-Encrypted: i=1; AJvYcCXM1i0GKEhvr8f1CpKvxvh7BiOchoWsje9tj1cENammZUlODpe6nE9HSt6HMTcYOetbTlFE2Ivl9R6HWl3a3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTJVlK7qfdLbvdc0bVlAtcdZgb/n8o6bX3tC874xJVpikDsn1k
	Ptc6JOc/+dtedyDJKbplmaWgQdqiwrcoNW2a8jObXVrzCFWb2Bq1BHakj0wCsJwOEwgvQ3qiTxB
	Kr8setS6XT6uPn92qCemLe2Es/JIIWSbz63cvUJ3Mjl3Yf2LM3mkTNDquW99zBIJ0H/v4
X-Gm-Gg: ASbGncs3t3uQSQ1Ti444qrnAyWbKs5xg6Roi8wgWtT1Ea7HovB69ZbcjyrpKiNhrl5E
	+42r01IH5jfyLEHNGgipZ+OXJAHh4o+T5bBclglnTTH6a9KAFUrsBJw8ZwSlHwqtE9Y5f294K4J
	NvTcDGt06D+vbB5fdBV/IuSvmMwV8zBtW89vXjiSymjsTTq6wbhPoSMazFPSoDMjhuqna+ww6TS
	fE/SjbJlacCuIaEWIdqcslUd1Bojh2IDdI9/cWFA78nmMZ1Eku90Co/EGJij8EzoFCLSXWLMIj8
	VqRsZPxMec9opjBiHg5RupnjIRE5bqxQAeTdxy8gvMcV8WbLXhn7JJ+CIYuZiNCIoJA9GCBmoTK
	alIozcm8=
X-Received: by 2002:adf:b643:0:b0:3a4:ee3f:e9a6 with SMTP id ffacd0b85a97d-3b5f18a7a4dmr128551f8f.54.1752164356602;
        Thu, 10 Jul 2025 09:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVAL5FTUNSY5NUppJgN69V9ZILsCc0pG1G2fmP70vWMvaMiOrIkOTJseQOmniZXHYXrNxzCA==
X-Received: by 2002:adf:b643:0:b0:3a4:ee3f:e9a6 with SMTP id ffacd0b85a97d-3b5f18a7a4dmr128529f8f.54.1752164356213;
        Thu, 10 Jul 2025 09:19:16 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1ee1sm2221730f8f.23.2025.07.10.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:19:15 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, David Vernet
 <dvernet@meta.com>, Barret Rhoden <brho@google.com>, Josh Don
 <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Juri Lelli
 <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Mel Gorman
 <mgorman@suse.de>, Vincent Guittot <vincent.guittot@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Wander Lairson Costa <wander@redhat.com>,
 lclaudio00@gmail.com
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
In-Reply-To: <aGvTz5VaPFyj0pBV@uudg.org>
References: <aGvTz5VaPFyj0pBV@uudg.org>
Date: Thu, 10 Jul 2025 18:19:14 +0200
Message-ID: <xhsmhtt3k10jh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lpA5GvQQS4PZP_cTrkrhGoNEW6KTnMVPNaAyuUL-EzM_1752164357
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 07/07/25 11:03, Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
>
>         rt_mutex_adjust_prio_chain()
>           put_task_struct()
>             __put_task_struct()
>               sched_ext_free()
>                 spin_lock_irqsave()
>                   rtlock_lock() --->  TRIGGERS
>                                       lockdep_assert(!current->pi_blocked_on);
>
> This is not a SCHED_EXT bug. The first cleanup function called by
> __put_task_struct() is sched_ext_free() and it happens to take a
> (RT) spin_lock, which in the scenario described above, would trigger
> the lockdep assertion of "!current->pi_blocked_on".
>
> Crystal Wood was able to identify the problem as __put_task_struct()
> being called during rt_mutex_adjust_prio_chain(), in the context of
> a process with a mutex enqueued.
>
> Instead of adding more complex conditions to decide when to directly
> call __put_task_struct() and when to defer the call, unconditionally
> resort to the deferred call on PREEMPT_RT to simplify the code.
>
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Reviewed-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

FWIW:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

