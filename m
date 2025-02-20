Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B551EFF9B
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048647; cv=none; b=Yyk2fPzllhhDZ60AiTvCCgrCQp7wYVB1y075+52SyAhMLN78TD/VIZa/iAM9RD8+RHjgzRl1k7Q59laovHZYGWrz3PLjvIjW7b64s0qEIRSV3lFl5SoSsY4KNPTZA4PDolsPL+IVmbDsuGMhRRMHN3f266y8k8zWe8TTRufgxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048647; c=relaxed/simple;
	bh=7jAGUhPkzWdpwuz4DF7mm7xOOz+bkeMzV0By/x99+Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCrgbkSTy1n9T6W8t6yIMlmOM8DsECXolJhDpGxH+iLZNX5APgVigPICuf7HOh/T6frhLIrRrDQFtgIfwdEF7T5KOhURvkLA8pqHgZEhQSB1ekKwMThHgMDLhkdl5Yo5rOjvga/oFruoIvYSUeYpInRBy7UxjZeM6nUs5twty90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H03vUt+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H03vUt+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740048645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+AenvsQ1d6MPmfyCdGSYtFDyZCiwe9jU60P8xlWbeY=;
	b=H03vUt+7qsN8421LulzPLTw0Qs0WLuQg6pAxcwgT+FY+grYBqFlUjqd592DyWWxMGUHA5r
	0tPHyE2Z5FrhDVdzpFgsOjaWpl3m6SgSyXTb6Rp1qoIXBQ5yVvCUbRT1TzHYDBDN0NZjON
	bDdHN95q43riUuc3RGsGMbFIfUbZcaM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-YyL-k6s4Pk6FeuAdxlHMpw-1; Thu,
 20 Feb 2025 05:50:40 -0500
X-MC-Unique: YyL-k6s4Pk6FeuAdxlHMpw-1
X-Mimecast-MFC-AGG-ID: YyL-k6s4Pk6FeuAdxlHMpw_1740048639
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A63DE19783B5;
	Thu, 20 Feb 2025 10:50:38 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.128])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E44001800352;
	Thu, 20 Feb 2025 10:50:32 +0000 (UTC)
Date: Thu, 20 Feb 2025 07:50:30 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	clrkwllms@kernel.org, jgarzik@redhat.com, yuma@redhat.com, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <h22s3ne3jgfyzryfd5htsaopoboqr6ljz7xtkkccoaaurpq6dv@o3wjen7rxs7r>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de>
 <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219102916.78b64ee4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219102916.78b64ee4@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 19, 2025 at 10:29:16AM -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2025 11:50:55 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
> 
> >      kworker/0:0-8       [000] b..13  2121.730643: e1000_init_hw_vf <-igbvf_reset
> >      kworker/0:0-8       [000] b..13  2121.730643: e1000_rar_set_vf <-e1000_init_hw_vf
> >      kworker/0:0-8       [000] b..13  2121.730643: e1000_write_posted_mbx <-e1000_rar_set_vf
> >      kworker/0:0-8       [000] D.Zf2  2121.730645: igbvf_reset_L14: (igbvf_reset+0x62/0x120 [igbvf])
> >      kworker/0:0-8       [000] .N...  2121.730649: igbvf_reset_L16: (igbvf_reset+0x7b/0x120 [igbvf])
> >   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_msix_other <-irq_thread_fn
> >   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_rd32 <-igb_msix_other
> >   irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst <-igb_msix_other
> >   irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst_pf <-igb_msix_other
> > 
> 
> > This is the trace-cmd command line I ran:
> > 
> > $ trace-cmd start -p function -l 'e1000*' -l 'igb*' -l process_one_work -e irq:irq_handler_entry -e probe
> >   plugin 'function'
> > 
> > The threaded interrupt handler is called right after (during?)
> > spin_unlock_bh(). I wonder what the 'f' means in the preempt-count
> > field there.
> 
> The preempt count is hex, so 'f' means 15. But that that latency field looks corrupted.
> 
> After adding the probes by perf, what's the content of the format files for them?
> 
> That would likely be in /sys/kernel/tracing/events/probe/*/format
> 

$ cd /sys/kernel/tracing/events/probe/
$ cat igbvf_reset_L1*/format
name: igbvf_reset_L14
ID: 2610
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:unsigned long __probe_ip; offset:8;       size:8; signed:0;

print fmt: "(%lx)", REC->__probe_ip
name: igbvf_reset_L16
ID: 2611
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:unsigned long __probe_ip; offset:8;       size:8; signed:0;

print fmt: "(%lx)", REC->__probe_ip

> Thanks,
> 
> -- Steve
> 

