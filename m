Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971C3BB9F4
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787944633; cv=none; b=iUOezwM4pZ64OFI2vXqq+Smd6KXNhgaVNIPmEag/mHAUcuKDNCt8rpvmHR1mJYnXwwwpk5jfeEvAUCrPEbqtvdsQOTfRC2ZL31SQz7GD2O82tm7JZy8V3POgkRirLzYq4lgR8FE94aeYd/w9bYzBb50eEnaoerkWJZ9rACk53Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787944633; c=relaxed/simple;
	bh=OjCe3CktZlYFOQFPLmGRlHo4AyWyH9sO8Gk+RrBAlYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ng0ual3yZb/rNyxXWGKwfdSj3aYJcOWBfqrmtdcgnc5weys/QGyoUI0jXsmYePFtPoK5HZ/F3bYHvjlwFwwvFl4b1e6jT09VsvyCk0/FhmZyXpQVzod2uoKDRo+uM6FUvSVa+v7cx8IJ7F5OnC7jEja2ysdlYeH8S+F/nuU+svU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=gAZTVjGD; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="gAZTVjGD"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C52951A053F;
	Fri, 28 Aug 2026 19:17:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id C3E9F20011;
	Fri, 28 Aug 2026 19:16:57 +0000 (UTC)
Date: Fri, 28 Aug 2026 15:17:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, David Stevens
 <stevensd@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Chinner
 <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Uladzislau
 Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook
 <kees@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 suleiman@google.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260828151747.20035d50@gandalf.local.home>
In-Reply-To: <20260828151313.5c4a5e4b@gandalf.local.home>
References: <20260827232948.2520558-1-stevensd@google.com>
	<20260827232948.2520558-7-stevensd@google.com>
	<20260828133620._x2XfJR_@linutronix.de>
	<20260828135947.GU776954@noisy.programming.kicks-ass.net>
	<20260828151018.HnR9xV1N@linutronix.de>
	<20260828150836.2d5b378c@gandalf.local.home>
	<20260828151313.5c4a5e4b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C3E9F20011
X-Stat-Signature: j65tfsnn7wb96ijjjfomjeapo6aro4m7
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FRCRqi3s+JC4roW7NUQua3g10tn9P4XM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=0RDwr71FlsrAMrAAlqln64IM9QGsxwXWA77DtZDfZwQ=; b=gAZTVjGDveN8fhsH4aJV2blL0f0S/QpEEvr3BQpYaHupiEQdLMD69nFOfdLEk1spL0/g6lXtTnfNyIqHZGTSM2GCgE4DvzYvzij8bAWlZRrSpkm67+yI+NJTg387b0JmME/jtx2tEqWIUYUrCD2W7DFVoX4NatssuHtJiesq2nE=
X-HE-Tag: 1787944617-357454
X-HE-Meta: U2FsdGVkX1+ViF3OvOgaM5ssQLR7tn0uySWJaFHYtcXWZ21cz7nnxMRW6iHpDWrp6Htrs0cIkgW4SbBQGFpZUf1ROkYnZEWGOtcWKXjDukDAh5xQHzSUkPxJbyaumnTpSqP3YXkkCipkNohafMlloaOqbdI5ACVjC77j7iGbrpU8lCltcFJhtONUqXBCJpw9eTajIr0/aLHn6NisdoeErwIxVK/oB2Np5iYGqcWQEGRVIxOt9i1N8E1VkhWj8uFuSoYqfpNN0eEmhPs7aE8vmz2WPbGl+v4Ry92BAG7LkkOQAqWIZjLFKEu432FqDcWspoc2zzLFnstcV5vVdG65ka7IObsOxeMhd+5KlkygWN4xwraefOr4pQuVKgzS9Rrd

On Fri, 28 Aug 2026 15:13:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> If one worries about stack size, they may want to turn off
> CONFIG_RANDOMIZE_KSTACK_OFFSET as I see some big numbers for do_syscall_64()

And the scheduler has some heavy stack usage here!

  # trace-cmd stack
(stack tracer running)
        Depth    Size   Location    (31 entries)
        -----    ----   --------
  0)     8120      48   __msecs_to_jiffies+0x9/0x30
  1)     8072     104   update_group_capacity+0x94/0x960
  2)     7968     528   update_sd_lb_stats.constprop.0+0x426/0x39b0
  3)     7440     424   sched_balance_find_src_group+0x8f/0x1150
  4)     7016     552   sched_balance_rq+0x934/0x4130
  5)     6464     408   pick_task_fair+0xa71/0x1fe0
  6)     6056     496   __schedule+0x628/0x76f0
  7)     5560      32   schedule+0xde/0x2c0
  8)     5528      32   io_schedule+0x8c/0x100
  9)     5496     256   rq_qos_wait+0x12b/0x230
 10)     5240     136   wbt_wait+0x150/0x260
 11)     5104      40   __rq_qos_throttle+0x51/0xa0
 12)     5064     304   blk_mq_submit_bio+0xc40/0x28e0
 13)     4760     240   submit_bio_noacct_nocheck+0x410/0xb30
 14)     4520      40   ext4_io_submit+0xca/0x1a0
 15)     4480     144   ext4_bio_write_folio+0x5e2/0x1470
 16)     4336      96   mpage_process_page_bufs+0x392/0x700
 17)     4240     616   mpage_prepare_extent_to_map+0xaae/0x1120
 18)     3624     480   ext4_do_writepages+0x971/0x37f0
 19)     3144     312   ext4_writepages+0x2d2/0x610
 20)     2832     152   do_writepages+0x21e/0x560
 21)     2680     184   __writeback_single_inode+0x119/0x1240
 22)     2496     752   writeback_sb_inodes+0x67d/0x17b0
 23)     1744     168   __writeback_inodes_wb+0xf2/0x270
 24)     1576     304   wb_writeback+0x63e/0x890
 25)     1272     320   wb_workfn+0x844/0xca0
 26)      952     360   process_one_work+0x8b4/0x15d0
 27)      592     176   worker_thread+0x5d3/0xfb0
 28)      416      64   kthread+0x33c/0x420
 29)      352     160   ret_from_fork+0x65c/0x9e0
 30)      192     192   ret_from_fork_asm+0x1a/0x30

Note, I'm running this on my server. That is, this is a production machine.

-- Steve
