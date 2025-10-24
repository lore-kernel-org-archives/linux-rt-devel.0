Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305D2DEA89
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Oct 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319293; cv=none; b=ZFUCNugxAJ9fpRURDGhg64xU+BSZYTOe6cGXOFzjuGOurVMrbITHKuizCHPWtne6PuuUGipJxhx02i5A3vwscZYq2PaDW8izuttuNR9bPEVUZ/LvzTSu93jRS7e/yEOtVzK/SBpsduyFZjeDmhkwUSmjEdJ5k4pxoPLejT9MqnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319293; c=relaxed/simple;
	bh=XhY8BiSTinI90ozZrWqRWXAea8xV/p4z/Bz/V0R1HJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQXNFsu8yIAsDuFJERvLAOg+4Nc9mqJH7rT+5Tc2pbklayg+u2S0WEY5XF0cpw1/qdwAHE5BuF+q1bFJP+FojPkFaJkXJA1sBVV49ZRetm9S/H2rCMHV0Jzin0iw4LZW4FJiF/GQls1UEjVET/45+HlGIj70llRbBvG/wrVMxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jL9xRkWn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jL9xRkWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761319290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhY8BiSTinI90ozZrWqRWXAea8xV/p4z/Bz/V0R1HJs=;
	b=jL9xRkWnrUVOy0ykW/t/W/qPVuzn3G9j5CN11Bbyy9PxBQ7bsSjxxhHG9Ai4lQzNFlH3cE
	arJFkV9aoE+GZHad53HFbPy/w26akOODdIWAgiWzoP55A1nkRWI0+RprqVVnmKHBgyLrk8
	6r4+orwgcMTmWEycUGC24Ve6WwBxsgU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-W1tf5ks9OjWukPM9116WLg-1; Fri,
 24 Oct 2025 11:21:27 -0400
X-MC-Unique: W1tf5ks9OjWukPM9116WLg-1
X-Mimecast-MFC-AGG-ID: W1tf5ks9OjWukPM9116WLg_1761319285
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E98AA1800675;
	Fri, 24 Oct 2025 15:21:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9B15130002DB;
	Fri, 24 Oct 2025 15:21:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Oct 2025 17:20:06 +0200 (CEST)
Date: Fri, 24 Oct 2025 17:19:57 +0200
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
Message-ID: <20251024151956.GH771@redhat.com>
References: <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
 <20251023135316.1ZRx0UU5@linutronix.de>
 <20251023152942.GC26461@redhat.com>
 <20251023153750.C6EU9NL6@linutronix.de>
 <20251023155339.GE26461@redhat.com>
 <20251023192353.Wkng87fi@linutronix.de>
 <20251024102616.GD771@redhat.com>
 <20251024103934.n4Lx1b9O@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024103934.n4Lx1b9O@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/24, Sebastian Andrzej Siewior wrote:
>
> On 2025-10-24 12:26:16 [+0200], Oleg Nesterov wrote:
> > > | /* PREEMPT_RT kernels map spinlock to rt_mutex */
> >
> > Ah, indeed, I was confused and didn't even bother to read the definitions
> > below, spinlock->dep_map is initialized by the same SPIN_DEP_MAP_INIT()...
> >
> > Sebastian, thanks for correcting me! Sorry, I could not carefully read
> > your emails yesterday.
>
> No worries. Just let me know if the cited comment requires an update.

No, no, I think the comment is fine. Just the ignorance on my side.

Oleg.

