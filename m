Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842435A3B1
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787944082; cv=none; b=PeFFH0RSkWBt6SB/4J+Xy3um94G4J4P3Q0pVzrMo0eq3utN1C+oUMD66W04VcZOIvmmlxdJ0WJG1/g7njGfZNyMlnJTvlmQdpgobggRG0IYv1qqrxt+wtJTbqFbKtyU5lvZCiV+TpxT1+UJGPGfr9ce3Rgwz+bZVvsbIYBbMwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787944082; c=relaxed/simple;
	bh=o5WMiRtczlMj8aCzx0HZGimrMc8BtlDx3pCmgkhCjVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2qwHjr5Yg5yS8b86tWdXqshsMzKWw6/yU4/wcIqSIyZ81lhluksEPB9wZtYNBkp3fzrrwyb9Qfeg72b1nsT29f7Cp/zuMm5bktRXNgeXNot/Au7Ws/j5uFNk+/J0ni+NXn9kU2Ow3zjLFrG4xsQJcOCZz1XBzSKuoKZXiD8+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=PAuX2eum; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="PAuX2eum"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 3BE7D80576;
	Fri, 28 Aug 2026 19:07:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 63A9220030;
	Fri, 28 Aug 2026 19:07:46 +0000 (UTC)
Date: Fri, 28 Aug 2026 15:08:36 -0400
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
Message-ID: <20260828150836.2d5b378c@gandalf.local.home>
In-Reply-To: <20260828151018.HnR9xV1N@linutronix.de>
References: <20260827232948.2520558-1-stevensd@google.com>
	<20260827232948.2520558-7-stevensd@google.com>
	<20260828133620._x2XfJR_@linutronix.de>
	<20260828135947.GU776954@noisy.programming.kicks-ass.net>
	<20260828151018.HnR9xV1N@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 63A9220030
X-Stat-Signature: qfnccbb99bbdi8st4d7w1x16uzo3fqsi
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+hstgiEjxGj1qjeta+VJO9YmsPembJtic=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=iz9Z9bs2yaO0uX8X+NUUGGiRu5Z62aRatCnxgmGQF+g=; b=PAuX2eumiKoGnLpY5f2+nm1ZATl/EOmUjI/FpV343XmFEFbowkFJmql3TZ1jDF1zuxI7uBH2uMShSP5U+TAscRfUBR9oh1x+t0dQtAljRuUvKaoZDY8JWuPoBS97OtDAg2ak8UoAQy18o2uUlaGBaHG6dRHa85Cm1TzLH79+Sx8=
X-HE-Tag: 1787944066-559064
X-HE-Meta: U2FsdGVkX18U+OOzmbS2v7qR7lqORVcgk0uJsd4pkhcItvYG+24rlhF4ua5cRunBcYiDvk8rYgLbmXs/0MxeE0s/dEd+FjrLEJn/AycQVURIxyo4rzRtjDYatkcwbpTyQECqMN/Wus6AbwXpziKNmrDRuLR04URK1/zW97dGFmeH7TWUpmWhcqBpwYZ8VgsB4W5dK++Zbf3JGighkdJdtKpSkazEYldOZbb5m9xR/iLZO8WEUXb4LaN8UmW7msMMHKqS7eR1vXglMkO6vofVREg91wkxVK9Hwf4/gjRglGRSo4pZTEeZNnJ/wPnaBfJI

On Fri, 28 Aug 2026 17:10:18 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > THREAD_SIZE_ORDER	2
> > THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
> >=20
> > that makes for 4 pages. =20
>=20
> Oh. I wasn't aware that we have 16kib stacks these days. But looking
> at it we have it now for over 10 years=E2=80=A6 Judging from 6538b8ea886e4
> ("x86_64: expand kernel stack to 16K") it might be temporary and things
> are better now? Arm64 has a different story according to 845ad05ec31e0
> ("arm64: Change kernel stack size to 16K"). Risc-V also mentions "for
> now" in 0cac21b02ba5f ("riscv: use 16KB kernel stack on 64-bit").
>=20
> I just booted my XFS kvm box and did things and 8KiB works so far.

If you want to see how big your stack is and where its used, you can run
the stack tracer:

 # trace-cmd stack --start

[wait]

 # trace-cmd stack
(stack tracer running)
        Depth    Size   Location    (41 entries)
        -----    ----   --------
  0)     5032      48   choose_idle_cpu+0x5/0x100
  1)     4984     296   select_task_rq_fair+0xa84/0x2b40
  2)     4688     104   try_to_wake_up+0x168/0x7e0
  3)     4584      16   task_work_add+0xd7/0xf0
  4)     4568      16   io_req_normal_work_add+0x75/0xb0
  5)     4552      40   io_poll_wake+0x10f/0x160
  6)     4512      64   __wake_up_common+0x72/0xa0
  7)     4448      40   __wake_up_sync_key+0x43/0x60
  8)     4408      24   sock_def_readable+0x46/0xe0
  9)     4384      80   tun_net_xmit+0x240/0x550 [tun]
 10)     4304      80   dev_hard_start_xmit+0x63/0x1e0
 11)     4224     256   __dev_queue_xmit+0x880/0x10b0
 12)     3968      24   br_dev_queue_push_xmit+0x62/0xf0 [bridge]
 13)     3944      80   br_dev_xmit+0x15e/0x4a0 [bridge]
 14)     3864      80   dev_hard_start_xmit+0x63/0x1e0
 15)     3784     256   __dev_queue_xmit+0x880/0x10b0
 16)     3528      72   ip_finish_output2+0x2ce/0x650
 17)     3456     104   ip_output+0x63/0x110
 18)     3352      72   __ip_queue_xmit+0x16f/0x470
 19)     3280     232   __tcp_transmit_skb+0xcb5/0x1140
 20)     3048     120   tcp_write_xmit+0x5aa/0x1760
 21)     2928      24   __tcp_push_pending_frames+0x39/0x110
 22)     2904     104   tcp_rcv_established+0x37f/0xeb0
 23)     2800      32   tcp_v4_do_rcv+0x13f/0x300
 24)     2768     168   tcp_v4_rcv+0xc01/0x1300
 25)     2600      48   ip_protocol_deliver_rcu+0x35/0x1b0
 26)     2552      24   ip_local_deliver_finish+0x85/0x100
 27)     2528      40   __netif_receive_skb_one_core+0x85/0xa0
 28)     2488      56   netif_receive_skb+0x127/0x180
 29)     2432     104   br_handle_frame_finish+0x428/0x680 [bridge]
 30)     2328      40   br_handle_frame+0x132/0x2a0 [bridge]
 31)     2288     280   __netif_receive_skb_core.constprop.0+0x16e/0xdf0
 32)     2008      40   __netif_receive_skb_one_core+0x39/0xa0
 33)     1968      56   netif_receive_skb+0x127/0x180
 34)     1912     256   tun_get_user+0xbd0/0x1260 [tun]
 35)     1656      56   tun_chr_write_iter+0x77/0xba [tun]
 36)     1600      88   do_iter_readv_writev+0x161/0x260
 37)     1512     256   vfs_writev+0x168/0x3c0
 38)     1256      80   do_writev+0x7f/0x110
 39)     1176     984   do_syscall_64+0xaa/0x670
 40)      192     192   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Note, it only monitors task context (not interrupt).

-- Steve
