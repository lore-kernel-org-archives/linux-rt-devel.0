Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276141FCD07
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Feb 2025 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786132; cv=none; b=K6raBo75lNs2cIP072Xp+YlzDbZXh+eP3emLQ4tJ/SioqWREoc9IPEAdvzPLm6Abva/TDIeEbN0/gljoMPuT+WpYdXRveZi3p99+S5v6C+XwkVrvWrnMFGmF+LEjjBYYbHgz19+oH2YvvWLLxaY5rZJmvF4shoJmCgYwSPx/HGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786132; c=relaxed/simple;
	bh=48MpIc2k/jmY6t1ssxUJmm8tTwOgHOeMG5JQpI2vmhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbxmXm8lH3OHP58Uy5ugDnMVtRRYQ/R646xFB8gziHTK1g5BN6HzJPzdjFifPEEJqsxdU+2sFBQWdzDzpJpPro0SiZYBf8TYvvgBdCaWIvzM6JHmPkeAlCrTWQ1i3udstfDDhKACeAgUgeNunPQoYUvKC3jjvnV+JUUKMhHzLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M66b41vn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M66b41vn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738786128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+33+Ba770uAWZtcvAI/AKlCQsR645ObAcdThYuTeEVg=;
	b=M66b41vnysiVyYwcpRkjqiw9XS7m2zyJk/lvAkMmxJTJvT8FZCgRdjYmvoutUwy4mllPK5
	u91JlN1iHDzm4EcRdRs0dbOEGBVgrUmwXL5KTtFXo1ZNtt3H2X9Isa+D1TtbFVTuAkbk8M
	iLftufEJU7Hr0YOfReNMwoG5bZ5w5do=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-JPd_PKP3ML6oGb8Ch3XJQA-1; Wed,
 05 Feb 2025 15:08:46 -0500
X-MC-Unique: JPd_PKP3ML6oGb8Ch3XJQA-1
X-Mimecast-MFC-AGG-ID: JPd_PKP3ML6oGb8Ch3XJQA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75EB31956096;
	Wed,  5 Feb 2025 20:08:44 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D79E1800878;
	Wed,  5 Feb 2025 20:08:36 +0000 (UTC)
Date: Wed, 5 Feb 2025 17:08:35 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, jgarzik@redhat.com, 
	yuma@redhat.com, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205094818.I-Jl44AK@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 05, 2025 at 10:48:18AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-04 09:52:36 [-0800], Tony Nguyen wrote:
> > Wander Lairson Costa says:
> > 
> > This is the second attempt at fixing the behavior of igb_msix_other()
> > for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> > concerns raised by Sebastian [3].
> 
> I still prefer a solution where we don't have the ifdef in the driver. I
> was presented two traces but I didn't get why it works in once case but
> not in the other. Maybe it was too obvious.

Copying the traces here for further explanation. Both cases are for
PREEMPT_RT.

Failure case:

kworker/-86      0...1    85.381866: function:                   igbvf_reset
kworker/-86      0...2    85.381866: function:                      e1000_reset_hw_vf
kworker/-86      0...2    85.381867: function:                         e1000_check_for_rst_vf
kworker/-86      0...2    85.381868: function:                         e1000_write_posted_mbx
kworker/-86      0...2    85.381868: function:                            e1000_write_mbx_vf
kworker/-86      0...2    85.381870: function:                            e1000_check_for_ack_vf // repeats for 2000 lines
...
kworker/-86      0.N.2    86.393782: function:                         e1000_read_posted_mbx
kworker/-86      0.N.2    86.398606: function:                      e1000_init_hw_vf
kworker/-86      0.N.2    86.398606: function:                         e1000_rar_set_vf
kworker/-86      0.N.2    86.398606: function:                            e1000_write_posted_mbx
irq/65-e-1287    0d..1    86.398609: function:             igb_msix_other
irq/65-e-1287    0d..1    86.398609: function:                igb_rd32
irq/65-e-1287    0d..2    86.398610: function:                igb_check_for_rst
irq/65-e-1287    0d..2    86.398610: function:                igb_check_for_rst_pf
irq/65-e-1287    0d..2    86.398610: function:                   igb_rd32
irq/65-e-1287    0d..2    86.398611: function:                igb_check_for_msg
irq/65-e-1287    0d..2    86.398611: function:                igb_check_for_msg_pf
irq/65-e-1287    0d..2    86.398611: function:                   igb_rd32
irq/65-e-1287    0d..2    86.398612: function:                igb_rcv_msg_from_vf
irq/65-e-1287    0d..2    86.398612: function:                   igb_read_mbx
irq/65-e-1287    0d..2    86.398612: function:                   igb_read_mbx_pf
irq/65-e-1287    0d..2    86.398612: function:                      igb_obtain_mbx_lock_pf
irq/65-e-1287    0d..2    86.398612: function:                         igb_rd32

In the above trace, observe that the ISR igb_msix_other() is only
scheduled after e1000_write_posted_mbx() fails due to a timeout.
The interrupt handler should run during the looping calls to
e1000_check_for_ack_vf(), but it is not scheduled because
preemption is disabled.

Note that e1000_check_for_ack_vf() is called 2000 times before
it finally times out.

Sucessful case:

      ip-5603    0...1  1884.710747: function:             igbvf_reset
      ip-5603    0...2  1884.710754: function:                e1000_reset_hw_vf
      ip-5603    0...2  1884.710755: function:                   e1000_check_for_rst_vf
      ip-5603    0...2  1884.710756: function:                   e1000_write_posted_mbx
      ip-5603    0...2  1884.710756: function:                      e1000_write_mbx_vf
      ip-5603    0...2  1884.710758: function:                      e1000_check_for_ack_vf
      ip-5603    0d.h2  1884.710760: function:             igb_msix_other
      ip-5603    0d.h2  1884.710760: function:                igb_rd32
      ip-5603    0d.h3  1884.710761: function:                igb_check_for_rst
      ip-5603    0d.h3  1884.710761: function:                igb_check_for_rst_pf
      ip-5603    0d.h3  1884.710761: function:                   igb_rd32
      ip-5603    0d.h3  1884.710762: function:                igb_check_for_msg
      ip-5603    0d.h3  1884.710762: function:                igb_check_for_msg_pf
      ip-5603    0d.h3  1884.710762: function:                   igb_rd32
      ip-5603    0d.h3  1884.710763: function:                igb_rcv_msg_from_vf
      ip-5603    0d.h3  1884.710763: function:                   igb_read_mbx
      ip-5603    0d.h3  1884.710763: function:                   igb_read_mbx_pf
      ip-5603    0d.h3  1884.710763: function:                      igb_obtain_mbx_lock_pf
      ip-5603    0d.h3  1884.710763: function:                         igb_rd32

Since we forced the interrupt context for igb_msix_other(), it now
runs immediately while the driver checks for an acknowledgment via
e1000_check_for_ack_vf().

> In the mean time:
> 
> igb_msg_task_irq_safe()
> -> vfs_raw_spin_lock_irqsave() // raw_spinlock_t
> -> igb_vf_reset_event()
>   -> igb_vf_reset()
>     -> igb_set_rx_mode()
>       -> igb_write_mc_addr_list()
>          -> mta_list = kcalloc(netdev_mc_count(netdev), 6, GFP_ATOMIC); // kaboom?

Perhaps the solution is to preallocate this buffer, if possible.
Doing so would significantly simplify the patch. However, this
would require knowing when the multicast (mc) count changes.
I attempted to identify this but have not succeeded so far.

> 
> By explicitly disabling preemption or using a raw_spinlock_t you need to
> pay attention not to do anything that might lead to unbounded loops
> (like iterating over many lists, polling on a bit for ages, …) and
> paying attention that the whole API underneath that it is not doing that
> is allowed to.

I unsure if I understood what you are trying to say.

> 
> Sebastian
> 

