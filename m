Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7FB225397
	for <linux-rt-devel@lists.linux.dev>; Mon, 20 Oct 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972092; cv=none; b=sBB/Wh+JHiC1wBCAnmbEvL2gGJk7b15sLO7gguKY//w3boTkgchBoOTGMG7xfMJESiSngDHmtcDMb9lYx38NCHXtyd9OSEVqknZ5AV8oV3CrWz91TTkavWY/Gvhx4OuWp8ybKoo5DUu8CgF7Apy8c7bs/pUM1yeCQfzXIdvtBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972092; c=relaxed/simple;
	bh=LNF1MAAfty77I/LDBF5uqmiocLc54mXm/JDwlcGg52E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIOkZwYRoKvaoTfx634TD6Or2+NKMcNcylHp0rnLR26Xx43N3W0JK+Zv05N2oqT+nsZ8yK4msvsffSSV14Ypy0p9aGAaPN+DiT+9zJUGhhuJspq2p/mSktUA9ASA5DFff+ySxagaUquwLaWKvWvLzhQZ+wCc9mzRRdDCglja3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8IoKfXH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8IoKfXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760972089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eITRpGzIbo/nKelTRX4RMH3CUzwSa+uzzO6xY3AYjsE=;
	b=D8IoKfXH1DQpaXeQEmYiNdJet3wEx9NzzRlMX6ZRytJEqSnGHgO9QBe4cWnwo4a9ILx9yU
	1rCqByT40HUNQIQGZIE3NOnMZrK2wszaeW0WWxH321RJoRUktaHITfsNDz/7X35/s/9pbm
	UbunIUX4UoKEgN+WtrduIQQ7B0rrQs8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-HIdO8_mHMX-78wkJVpz9NQ-1; Mon,
 20 Oct 2025 10:54:46 -0400
X-MC-Unique: HIdO8_mHMX-78wkJVpz9NQ-1
X-Mimecast-MFC-AGG-ID: HIdO8_mHMX-78wkJVpz9NQ_1760972084
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F29AE1801226;
	Mon, 20 Oct 2025 14:54:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C6AE230001BC;
	Mon, 20 Oct 2025 14:54:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 20 Oct 2025 16:53:23 +0200 (CEST)
Date: Mon, 20 Oct 2025 16:53:10 +0200
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
Subject: usage of DEFINE_WAIT_OVERRIDE_MAP(LD_WAIT_SLEEP)
Message-ID: <20251020145310.GA9608@redhat.com>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811105948.OafBprND@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Sebastian,

(change subject to not add more confusion)

On 08/11, Sebastian Andrzej Siewior wrote:
>
> On 2025-08-01 12:24:29 [+0200], Oleg Nesterov wrote:
> > s/LD_WAIT_SLEEP/LD_WAIT_CONFIG/ needs another discussion even if I am right,
> > sorry for the confusion.
>
> You are correct Oleg. I've been just verifying it and yes: LD_WAIT_SLEEP
> suppresses also mutex while the intention is to only suppress
> spinlock_t.
> We have four users in tree, based on quick check all four should use
> CONFIG, three of them do use SLEEP.

No ;)

I was going to send the patch which does s/SLEEP/CONFIG/, but this
would be wrong. printk_legacy_map can use LD_WAIT_CONFIG, but lets
look at debug_objects_fill_pool()

	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
		/*
		 * Annotate away the spinlock_t inside raw_spinlock_t warning
		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
		 * the preemptible() condition above.
		 */
		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
		lock_map_acquire_try(&fill_pool_map);
		fill_pool();
		lock_map_release(&fill_pool_map);
	}

If CONFIG_PREEMPT_RT=y and preemptible() is true, LD_WAIT_CONFIG won't work.
lockdep will complain if fill_pool() takes a spinlock_t, spinlock is
LD_WAIT_SLEEP on RT.

I guess debug_objects_fill_pool() actually needs something like

	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
			lock_map_acquire_try(&fill_pool_map);

		fill_pool();

		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
			lock_map_release(&fill_pool_map);
	}

but this is obviously too ugly. I am wondering if we can cleanup this logic
somehow...

Oleg.

