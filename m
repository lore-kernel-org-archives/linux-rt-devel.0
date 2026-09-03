Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29C4E3EF4
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Sep 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450453; cv=none; b=gaGxkegJzNkTMgBoBj0YBO/x4pHPKdOwQp1szQBJMpLn+yS2rA7LU8ENrqX4DwahCKTQzGxv5GpGVSME4w2Mu7XZWFrw9p6dmk3ks3Asp9bYycXhcpOR1C0TQ122ylfkvwEFh7TLphVxWH7BJZFpPUMIiO0mDgAyXB3djcabMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450453; c=relaxed/simple;
	bh=wEV13BB12hSPDDxYRgrafQ+f5i8Bla9fwpAd0/5zxrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=G7ne0jGRgOTrLIpOYt88Z+O76EfKM2pJMWJaD5Iwu9GW12fk6XuTHy39jzWHbP6qS/lHEfV9J8XzpRdY8SFDtc+Wo+Byyg3lNxKj6MwFmY2F4L22l5YyrAtN55KwV0i/SOhfgiS+Z4hHRk5DRbXwqn6yghC2Vqn1bPtZIyuqgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzZGDyQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzZGDyQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788450451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16WL/1El7inuigano1WCYUIZILetE/HdUjRWFIwgXeA=;
	b=gzZGDyQC6zh+GFHWejKINL0Wk2k6x3iKphH1amjW5SonJxMmkKC49wWcULHQ4T+nTj2KVc
	OANpipNoUG8J+coT00f4hZdULjo0XHqDJYXsoryWrVSRhkSNmbg1Mjg6KgSjF1Pg6TtxVa
	HD+ROtR6I6bEhegQD3tq9z9Q3KPJUoo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-agi2M-QVPfeDTToq5PSLfQ-1; Thu,
 03 Sep 2026 11:47:27 -0400
X-MC-Unique: agi2M-QVPfeDTToq5PSLfQ-1
X-Mimecast-MFC-AGG-ID: agi2M-QVPfeDTToq5PSLfQ_1788450446
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4708B195DE60;
	Thu,  3 Sep 2026 15:47:26 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A70441955F0A;
	Thu,  3 Sep 2026 15:47:25 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:47:24 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <apmWjJquEQIHeFrW@redhat.com>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260814090304.558901F0155A@smtp.kernel.org>
 <20260814092049.EHIf1eeX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260814092049.EHIf1eeX@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 5grtVc9hQ9BWChBTzaXgvLQKqR4UxgiAJZa-_4rH01s_1788450446
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 14, 2026 at 11:20:49AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-14 09:03:03 [+0000], sashiko-bot@kernel.org wrote:
> > > +	if (xchg_relaxed(&bp->hw.arch_hw_notif_busy, 1) ||
> > > +	    WARN_ON_ONCE(task_work_add(current, &bp->hw.arch_hw_notif, TWA_RESUME)))
> > [Severity: High]
> > Will using TWA_RESUME here cause a hang if a hardware watchpoint is triggered
> > during a blocking syscall like futex() or read()?
> > 
> > When a blocking syscall accesses watched memory (e.g., via get_user()), the
> > watchpoint synchronously triggers and queues the SIGTRAP task work via
> > task_work_add(). Since TWA_RESUME only sets TIF_NOTIFY_RESUME, and
> > signal_pending() ignores TIF_NOTIFY_RESUME, the syscall wait loop will not
> > abort. 
> > 
> > Does this need to use TWA_SIGNAL instead so that TIF_NOTIFY_SIGNAL is set and
> > the interruptible sleep correctly aborts to deliver the pending task work?
> 
> Well, this only means that the signal will be delivered once the syscall
> handling is complete. I don't see a reason why the syscall should be
> interrupted just to deliver the signal right away. The logic should not
> be affected by delivering the signal immediately.
> 
> > > +		put_event(bp);
> > > +}
> > > +#endif

Sebastian, do you intend to perform any extra work on this patch or is it
ready for consumption? I have been using this change in test kernels for a
while now and haven't had a single problem so far.

Best,
Luis

> Sebastian
> 
---end quoted text---

