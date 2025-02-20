Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DD1F3FD0
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051334; cv=none; b=WBoOUbBp+MmQgRyeSFeDahMmVFlf9UnV/E4uLgqgfSEDnvf3Lt74JAAHEpaOJZEDweWbgNrVyqim8ojYMRszX8vAG8gcpF4MWDLabSZ2PNtJ5jJKgyrwBW09N1gfxio+nBy+mOCDLLDp7H1VTgy0tTdK72CHlwYrH+2jiou+NfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051334; c=relaxed/simple;
	bh=k5//dUeQAi0NOgrf1qVdhiarlA3ibLFztIeuufVoC8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH2kCOW7JmRNUFtzNTisTaJswj6JOb5ZlbtCGr1b7VMyN+Ag8iomPK4O/vf7oySiov/Km3OdONBGEaE7NtreUEqvhReG5kt4MdFVvUJ10qbKoz+p2yqSaY3hJWiAHh8L5KSH55/ba8H0rwEJqJII/fGOX9xtRaKU8t2YPaGZJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRuuMkp9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRuuMkp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740051331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2A55Z29B63jcHF/TTmWIeWcZ73NMKvEJKEezTwiZoKE=;
	b=dRuuMkp9LQys1iBCAIZkCpUtslpudv7/L4Ihc+42qWHi912z5qAiU6pwrbUuxEIVGki2J7
	/RPA2Ay/cEai014cbu7DhztMHs6VZDuC0bNLa8jBvnPt2U5Ekw9M/DD0K9cadWSJ1PbHNn
	StNarHCfaleImnZ+MeDfoP7/z1nHPAw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-CakbfZ-SOeiYCqt9frYV9Q-1; Thu,
 20 Feb 2025 06:35:27 -0500
X-MC-Unique: CakbfZ-SOeiYCqt9frYV9Q-1
X-Mimecast-MFC-AGG-ID: CakbfZ-SOeiYCqt9frYV9Q_1740051325
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24A8D180087F;
	Thu, 20 Feb 2025 11:35:25 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.128])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5738C180034D;
	Thu, 20 Feb 2025 11:35:19 +0000 (UTC)
Date: Thu, 20 Feb 2025 08:35:17 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, jgarzik@redhat.com, 
	yuma@redhat.com, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <kwmabr7bujzxkr425do5mtxwulpsnj3iaj7ek2knv4hfyoxev5@zhzqitfu4qo4>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de>
 <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219163554.Ov685_ZQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219163554.Ov685_ZQ@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 19, 2025 at 05:35:54PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-18 11:50:55 [-0300], Wander Lairson Costa wrote:
> > These logs are for the test case of booting the kernel with nr_cpus=1:
> > 
> >      kworker/0:0-8       [000] d..2.  2120.708145: process_one_work <-worker_thread
> >      kworker/0:0-8       [000] ...1.  2120.708145: igbvf_reset_task <-process_one_work
> 
> This looks like someone broke the function tracer because the preemtion
> level should be 0 here not 1. So we would have to substract one… This
> does remind me of something else…
> 

That fooled for quite a while. That's why I claimed the preemption was
disabled at beginning.

> …
> >      kworker/0:0-8       [000] b..13  2120.718620: e1000_reset_hw_vf <-igbvf_reset
> …
> >      kworker/0:0-8       [000] D.h.3  2120.718626: irq_handler_entry: irq=63 name=ens14f0
> ^ the interrupt.
> …
> >      kworker/0:0-8       [000] b..13  2120.719133: e1000_check_for_ack_vf <-e1000_write_posted_mbx
> >   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_msix_other <-irq_thread_fn
> >   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_rd32 <-igb_msix_other
> >   irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst <-igb_msix_other
> >   irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst_pf <-igb_msix_other
> 
> The threaded interrupt is postponed due to the BH-off section. I am
> working on lifting that restriction. Therefore it gets on CPU right
> after kworker's bh-enable.
> 
> …
> > The threaded interrupt handler is called right after (during?)
> > spin_unlock_bh(). I wonder what the 'f' means in the preempt-count
> > field there.
> 
> The hardware interrupt handler gets there while worker is in the wait
> loop. The threaded interrupt handler gets postponed until after the last
> spin_unlock_bh(). The BH part is the important part.
> With that log, I expect the same hold-off part with threaded interrupts
> and the same BH-off synchronisation.
> 
> > I am currently working on something else that has a higher priority, so
> > I don't have time right now to go deeper on that. But feel free to ask
> > me for any test or trace you may need.
> 
> I would need to check if it is safe to explicitly request the threaded
> handler but this is what I would suggest. It works around the issue for
> threaded interrupts and PREEMPT_RT as its user.
> You confirmed that it works, right?
> 

Do you mean that earlier test removing IRQF_COND_ONESHOT? If so, yes.

> Sebastian
> 

