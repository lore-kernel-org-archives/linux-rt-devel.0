Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3F25BF11
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Jun 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888122; cv=none; b=C6YK29FMGK5maUopA8lfOKFN7Dcdr1SovOH9iQYbNPJrVmlHajxFojAn5MQpXFqIt2jIm+z4+4wKJ+LVr1o1wg1zXoyY4NKRxgO6UzCv447lWfe7SfbNj7k5yz8CIKsGPn2KG6BqGl33dIXIUwbkw/jL2aUqAGWDeCkevh07vAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888122; c=relaxed/simple;
	bh=2Al1Xo1j+YCP/7/wS0Hh4MVF7Bsv2KTjyejkLKFeTL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNnGx3karKPnqBfCWRtO9TuU0I8IgtsjC8pFU1VCPWu26PyustCo52mahXBiSK00q783Y+MKblFBWsf7bfNbb5RZKYhevz0CoDEvuuBPmbNVRaNOMoEwS8sUSE7iFMyI+p/ypneJwLs440Uu5aCtHVucj/2E29Xg4MrciekU50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQL9DnYl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQL9DnYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750888119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yf7LN45AXmV/wr0eUVyPBaPat33AzTTVr9f1fotPlKU=;
	b=RQL9DnYlrrtzBaMLSDDHcjRUG84cJEhH/R3Hq7pJZLQkgR7uu3v/G44T8yuTJG7BbXj/vw
	y4Mkpj8FQuRijNzjM2UASjXSX111cYO4S6zglkfCLYiLkknpDWfTuqHVLMZ7iP2ro6fg04
	A4QDq2AUXj/1vet07fr02/MOo+9B3a0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-2RjUxyDcNvOI8O9inlMNuA-1; Wed, 25 Jun 2025 17:48:38 -0400
X-MC-Unique: 2RjUxyDcNvOI8O9inlMNuA-1
X-Mimecast-MFC-AGG-ID: 2RjUxyDcNvOI8O9inlMNuA_1750888117
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fd5e0bc378so7364536d6.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Jun 2025 14:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750888117; x=1751492917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yf7LN45AXmV/wr0eUVyPBaPat33AzTTVr9f1fotPlKU=;
        b=qO16GTAN+KFq9QySlG8947Wc+Lj0l6mYTqd9hkCKjv79q41CGZKM3wzGlNwtbsR/oG
         JQsmWeCh0e4BQGpIJ1yVeGP+bG1TzH7y6MzoSSbbNIu3P6f25E7Q4MABKXhAkKJaCuTh
         E2cD+txTKKrdxa6XfQTHtGwiU+rf2aJB2scqHySymMS1grvOPegUnh4whQcXnuLxKM6j
         MHwiQ2uIaRZtHndWzt3nJInsNCanvFg5PV27n7YMu6tTXQR3At03ysoQag5RzEivb6oA
         NV7/mMSHSywGJXnBbXSk36VPB7hxrpBlRs6sBoSUpISHSYYWrXRCu9+AXdcU8N0iwIP+
         Ijng==
X-Forwarded-Encrypted: i=1; AJvYcCVK5Z1Co09CcckBgy2abknZXdZHFA1FhiGyUnBXxnAp1IXpnRc2jN8v5He08dKnrfDRZhOCHgypflRoL1OFkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzozuPJ1onjxvwD1mS+XkEGkNt/DmJhB9gpbCnUgzcKihNxERGu
	6GX2w0zK7ePYGWJ0Yo4J9qQG3wL1EwwgwO16DELyoyqO0CmokLWdkl/I9BcQxKthGVQk68r33na
	/p5k91r9DguTfjv3XCGxFYPs16aALdSdSl+1D460exBP6OZpnqBOKfslW0xlyIrKZ3MKn
X-Gm-Gg: ASbGnctZ7vIbTrHuanPA45kNwB83PweNInj6Uno0PqwAIA4nwHkBbvMhYdkoYUuR3bO
	lSQ/7sHfSIjELuSWI7s54HZRpsSWfqz9ooCyXNydgpkt+gn2laBo4LOn1RT/ZfhE1MQt0sqbHRz
	pC/8HNCuSwwlle7ofcHaXh0iNCcBO5e8iQUIiF2MDnIsKY/lDrMiWJ5H24WP1wCwF8EDqAVWSG2
	W/IqAu2it5jgRWvNoRrCj+tv9QtLsPVZgH/d9+NaUlXiZz0fN5tKTrtNMP6byy74bRrhxIKaBCM
	eEkFGVffyrXvcuyhTuTszQugrKhHbtOqA01m7Z7ZevFGaGJYa/goAQ==
X-Received: by 2002:a05:620a:2721:b0:7d3:abb5:b57d with SMTP id af79cd13be357-7d429738d95mr576422685a.28.1750888117628;
        Wed, 25 Jun 2025 14:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsLCB6jZfeylnPbGC4ONnPG6FgPUPsCN7asxvidsIyT3qk0W5gzp71Re109/DyqgsCAMiPPA==
X-Received: by 2002:a05:620a:2721:b0:7d3:abb5:b57d with SMTP id af79cd13be357-7d429738d95mr576418985a.28.1750888117188;
        Wed, 25 Jun 2025 14:48:37 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772fcabdsm162736d6.85.2025.06.25.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 14:48:36 -0700 (PDT)
Message-ID: <d2e98b4d7f76534c68c1a0cc30fdd61b109cbd3c.camel@redhat.com>
Subject: Re: [PATCH v5] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
From: Crystal Wood <crwood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Clark Williams
 <clrkwllms@kernel.org>,  Steven Rostedt <rostedt@goodmis.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <dvernet@meta.com>, Barret Rhoden	
 <brho@google.com>, Josh Don <joshdon@google.com>,
 linux-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev, Juri Lelli
 <juri.lelli@redhat.com>, Ben Segall	 <bsegall@google.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ingo Molnar	 <mingo@redhat.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>
Date: Wed, 25 Jun 2025 16:48:35 -0500
In-Reply-To: <20250618070350.19JbjFnG@linutronix.de>
References: <aFF1BKtdQCnuYMaS@uudg.org>
	 <20250618070350.19JbjFnG@linutronix.de>
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O4B1BP3g5j0ckzeT8J1GRwhXXMnE49cz11d0rIR4SS8_1750888117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-06-18 at 09:03 +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-17 11:00:36 [-0300], Luis Claudio R. Goncalves wrote:
> > With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> > from rt_mutex_adjust_prio_chain() could happen in preemptible context a=
nd
> > with a mutex enqueued. That could lead to this sequence:
> >=20
> >         rt_mutex_adjust_prio_chain()
> >           put_task_struct()
> >             __put_task_struct()
> >               sched_ext_free()
> >                 spin_lock_irqsave()
> >                   rtlock_lock() --->  TRIGGERS
> >                                       lockdep_assert(!current->pi_block=
ed_on);
>=20
> Maybe with the addition of
>=20
> > The first case was observed with sched_ext_free().=20
> > Crystal Wood was able to reproduce the problem to __put_task_struct()
> > being called during rt_mutex_adjust_prio_chain().
>=20
> The first sentence will imply a Fixes: with the introduction of
> sched_ext. The second implies that the original fix was not complete and
> nobody managed to trigger it until now.

sched_ext_free() just happens to be the first cleanup function called,
so that's where the blowup happens.  I think the "nobody managed to
trigger it" was because we didn't have the pi_blocked_on assert until
recently -- and my "other cases with a similar cause" was probably older
kernels with the assert backported, but not sched_ext, so the backtrace
was different.

-Crystal

