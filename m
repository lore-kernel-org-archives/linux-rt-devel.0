Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F930F7F1
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301672; cv=none; b=u2XY0BHuExYAePSzyieECEZik783IC4m5Tn6PXz+kqBtkrjwPfH/EQEnEZhOoYC1MsAUn4CmvGR3RezkC8fn61P/GcM6DbohnzRA5XDXrGdwbmd9fmeZ+V++eSvy2D6kavPCkV0qdhwWETTlzySiabFfNmrT2bSXC3yVlae6gmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301672; c=relaxed/simple;
	bh=N2ajP2q9W7M7yvoN4wqZtQqLNgaUm/57gWLE4t8N9Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnqRBH6N+NodJkl2DG7H7iQcCAEiP3XfG5udPW/bYjwmayV2sBCID/39rCu65FjH5+0dpL6kPTzcDSBoWjgiO9W1y3z08BHi9/+HsWiK2pDbxAYlWWWhd3el4C1WSTI03VzdTK0KxjS79YJvCFpKmR76pl4Ij2P6dVNOAyGnSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMH+2PpI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMH+2PpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761301669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=op9gJxTu3V1l3M3YQdCe2LbH3bbhAoGT+rz90MVA+nU=;
	b=RMH+2PpImFDXJt5tVt2ubpFrUSgRDws1EfyBF28cyUo5gNdKEvAWHMJlmKUHGnz/7DmOby
	0XwklPfGYY0HLRmcUG4rgvl3YLXpQvb+X/sE0YUAMj+KmZiD8pOvhDQgeE3V40L98xH4qg
	orqA7DsOIgEBEthqIuObNG5jZJ4NpH8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-VYONG_KNMamzq3OWIdM9vg-1; Fri,
 24 Oct 2025 06:27:46 -0400
X-MC-Unique: VYONG_KNMamzq3OWIdM9vg-1
X-Mimecast-MFC-AGG-ID: VYONG_KNMamzq3OWIdM9vg_1761301664
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 650861954190;
	Fri, 24 Oct 2025 10:27:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 41084180057D;
	Fri, 24 Oct 2025 10:27:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Oct 2025 12:26:26 +0200 (CEST)
Date: Fri, 24 Oct 2025 12:26:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: usage of DEFINE_WAIT_OVERRIDE_MAP(LD_WAIT_SLEEP)
Message-ID: <20251024102616.GD771@redhat.com>
References: <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
 <20251023135316.1ZRx0UU5@linutronix.de>
 <20251023152942.GC26461@redhat.com>
 <20251023153750.C6EU9NL6@linutronix.de>
 <20251023155339.GE26461@redhat.com>
 <20251023192353.Wkng87fi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023192353.Wkng87fi@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/23, Sebastian Andrzej Siewior wrote:
>
> On 2025-10-23 17:53:40 [+0200], Oleg Nesterov wrote:
> > Sebastian,
> Hi Oleg,
>
> > sorry. I guess this is my fault, but I can't understand your reply...
> > Could you spell please?
>
> So you refer to this:
> | /* PREEMPT_RT kernels map spinlock to rt_mutex */
> | #include <linux/rtmutex.h>
> |
> | typedef struct spinlock {
> | 	struct rt_mutex_base	lock;
> | #ifdef CONFIG_DEBUG_LOCK_ALLOC
> | 	struct lockdep_map	dep_map;
> | #endif
> | } spinlock_t;
>
> spinlock_t on PREEMPT_RT does not use (struct) rt_mutex as the comment
> claims. It uses just the basic building block which is "struct
> rt_mutex_base". This requires linux/rtmutex.h.
>
> spinlock_t on PREEMPT_RT uses LD_WAIT_CONFIG via SPIN_DEP_MAP_INIT as
> !PREEMPT_RT. Nothing changes here.

Ah, indeed, I was confused and didn't even bother to read the definitions
below, spinlock->dep_map is initialized by the same SPIN_DEP_MAP_INIT()...

Sebastian, thanks for correcting me! Sorry, I could not carefully read
your emails yesterday.

Oleg.

