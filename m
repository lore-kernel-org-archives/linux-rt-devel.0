Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702401FDE09
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853459; cv=none; b=pZzpnrURZLMF08vS4iYZXkef9t05kAz77TOBXWb93sQEbxUAWgKG66dhJpgrshhlAlrm8r19ZSoOovTbymjtqqrwdI0au9vyoFWDLPUtzW+jSM3BGhVgZn/2+aSH0FqYEZsG0sMurjYRVcJ6vNTpAszvuhHMygnQ3trBAngN5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853459; c=relaxed/simple;
	bh=23spyynB0cqNsHrBwAdRF5C6HK5JcUDPHhLhZJ27dIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTF6O2Xm8+ykcEmS9dhIN9dTy7+UzuE1XbfSbElAl7vcLXzRTAU4Dn/R92yFBdFRiPW+T078NP9qyY7vM/A/reQjR+DY1ws1Y1Q/NqdA0j0LzmLHVkSZ3draV4pgio0vo+QCOxikJs4/Ao8M216tybMJI7fwyunpGhFfpmedJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFCpHiIG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFCpHiIG"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so4373553a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Oct 2025 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759853457; x=1760458257; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ww5A9QLVLF9MHFrBjtfqLgeO9mCIYxCjgSA4ZPNH8dU=;
        b=GFCpHiIGW5/ElQVYsKmka5Pne2HiupLKVRpZgXFKr5Y4jeZiyrUlstOePzJm//WeGJ
         vEQ7TfbyGisEHCmx0xI+RVzw6SWYUoywNoNe03P9935vzTJAUmDTipdDBQXxerZcyBOT
         PscCd0XXpBK65lePqcWNsU6cUfphLmoxez5/mYoChku1823GC2fJ1+V2jp9pqTaDWHqK
         F0n1NJkZe8f4XWsRJU6Z7HeCSJQ4RlYOR1juvFMOOWymsfkjnMF/wvLZrNtxVDNB1Q2t
         lWo9dq+QsvDRAcpEP4hPZ6dRDHSY6202fT4bAVp4MsYRvBRtlT6OKtDTaIn/ZnhKRyHT
         jk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853457; x=1760458257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ww5A9QLVLF9MHFrBjtfqLgeO9mCIYxCjgSA4ZPNH8dU=;
        b=YJHpnhy/cza0F09BU57NefCzyjlCcsKKW/tHyh5t6CJ1e9o8YsPYBM6WQ+QiRvSa4R
         6ZW0vX2tRysFyP18RO5TUPcjc1tacSFjxj8NOzOPEgMtuyA6bmD9lmJK7JIhEnvORX/E
         jsvkv6CcX2P2VuZBeRAqZK7DIeBD9IVgB0G+vxRtWkU4EAaYdTVsZt2g1wnUJXi7o9bW
         xUP/EguzTSa2PoFNiVcazBbwLsDtZYs6kk6jRGt3R33hS6AuiV4ACHI5wG3ZwGXgRLoD
         fJy1NJjeN4SnN4rRi+32EblhaOLZdxXDPPuYGub8Yt/qzKLNLc3e+pnGwa8NN2VCxb/Y
         kUeA==
X-Forwarded-Encrypted: i=1; AJvYcCU9mKXDxiS/XaGqc/dcJUZ1rmAizkahdO7WlyvSIdcHi/3FQVEQB/CtS/KQJKFEZVSQ9L0hiowa/5UahbkdIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNN3TJWFxFOtvAFcKn7cHRoSUR8RJnNoLd7GkWM1ngm+i9xGbc
	PV8vWB1CtH9vYMW1BGoqm6sWfEPusGuQpJEgvjviqWYvY2jXnXBc1+ydsdOA5h9G1Rzi/JUE4OB
	quZ+UGBFwu2E3QyLLTRaG2fa5QTqEnlM=
X-Gm-Gg: ASbGncsw3KjEIVCd+dSqJfQZhfAvPWHfV0Fa5DEx4UTRdNcNTE13z+s/1PHICO0RVPE
	7BE/hFP3eztPSMLWGWcDo9JXb8lqRXVIQsbyEW0pMFMONodEL8z1XDrz3Gk4SyUJkEQzU3GaxRQ
	61ooqquxM+Bwv6AAywzpHYytl7nByIhL380DVYtXbFk7FINLBKvJ6zow0lc/WE9XytIGsFk0DlB
	fbSmbTIFymeljU2N0sZypRwzOMG/e1r0cb+Vn8uWE0=
X-Google-Smtp-Source: AGHT+IGJJpzPBxcd6aeQej3XljQ3lxvUxspSqUl1LdUZeeFNyJ+K+vdK7I6p2lY3vune3YygMz/VZesA43Ks3Af09Ak=
X-Received: by 2002:a17:90b:3b49:b0:330:a301:35f4 with SMTP id
 98e67ed59e1d1-33b513b4b46mr44952a91.20.1759853456576; Tue, 07 Oct 2025
 09:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007060218.57222-1-jckeep.cuiguangbo@gmail.com> <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
In-Reply-To: <4ab58884-aad3-4c99-a5f9-b23e775a1514@redhat.com>
From: guangbo cui <jckeep.cuiguangbo@gmail.com>
Date: Wed, 8 Oct 2025 00:10:45 +0800
X-Gm-Features: AS18NWCS1wxb3gY3lfJbMPL239E4u53x8rH8x6LyTql4zmMXKbknajNjC1YY13M
Message-ID: <CAH6oFv+KYGZNzb7gySoyQAB3tn2CrH+H_-vi4E=4NS6pvTBHvw@mail.gmail.com>
Subject: Re: [PATCH] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Waiman Long <llong@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 07, 2025 at 11:13:33AM -0400, Waiman Long wrote:
> On 10/7/25 2:02 AM, Guangbo Cui wrote:
> > [ 1850.947170] pcieport 0000:00:02.0: aer_inject: Injecting errors 00000001/00000000 into device 0000:00:02.0
> > [ 1850.949951]
> > [ 1850.950479] =============================
> > [ 1850.950780] [ BUG: Invalid wait context ]
> > [ 1850.951152] 6.17.0-11316-g7a405dbb0f03-dirty #7 Not tainted
> > [ 1850.951457] -----------------------------
> > [ 1850.951680] irq/16-PCIe PME/56 is trying to lock:
> > [ 1850.952004] ffff800082865238 (inject_lock){+.+.}-{3:3}, at: aer_inj_read_config+0x38/0x1dc
> > [ 1850.952731] other info that might help us debug this:
> > [ 1850.952997] context-{5:5}
> > [ 1850.953192] 5 locks held by irq/16-PCIe PME/56:
> > [ 1850.953415]  #0: ffff800082647390 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x30/0x268
> > [ 1850.953931]  #1: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> > [ 1850.954453]  #2: ffff000004bb6c58 (&data->lock){+...}-{3:3}, at: pcie_pme_irq+0x34/0xc4
> > [ 1850.954949]  #3: ffff8000826c6b38 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
> > [ 1850.955420]  #4: ffff800082863d10 (pci_lock){....}-{2:2}, at: pci_bus_read_config_dword+0x5c/0xd8
> > [ 1850.955932] stack backtrace:
> > [ 1850.956412] CPU: 0 UID: 0 PID: 56 Comm: irq/16-PCIe PME Not tainted 6.17.0-11316-g7a405dbb0f03-dirty #7 PREEMPT_{RT,(full)}
> > [ 1850.957039] Hardware name: linux,dummy-virt (DT)
> > [ 1850.957409] Call trace:
> > [ 1850.957727]  show_stack+0x18/0x24 (C)
> > [ 1850.958089]  dump_stack_lvl+0x40/0xbc
> > [ 1850.958339]  dump_stack+0x18/0x24
> > [ 1850.958586]  __lock_acquire+0xa84/0x3008
> > [ 1850.958907]  lock_acquire+0x128/0x2a8
> > [ 1850.959171]  rt_spin_lock+0x50/0x1b8
> > [ 1850.959476]  aer_inj_read_config+0x38/0x1dc
> > [ 1850.959821]  pci_bus_read_config_dword+0x80/0xd8
> > [ 1850.960079]  pcie_capability_read_dword+0xac/0xd8
> > [ 1850.960454]  pcie_pme_irq+0x44/0xc4
> > [ 1850.960728]  irq_forced_thread_fn+0x30/0x94
> > [ 1850.960984]  irq_thread+0x1ac/0x3a4
> > [ 1850.961308]  kthread+0x1b4/0x208
> > [ 1850.961557]  ret_from_fork+0x10/0x20
> > [ 1850.963088] pcieport 0000:00:02.0: AER: Correctable error message received from 0000:00:02.0
> > [ 1850.963330] pcieport 0000:00:02.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> > [ 1850.963351] pcieport 0000:00:02.0:   device [1b36:000c] error status/mask=00000001/0000e000
> > [ 1850.963385] pcieport 0000:00:02.0:    [ 0] RxErr                  (First)
>
> Changing inject_lock into a raw_spinlock is the most obvious solution as
> long as it meets the criteria that the lock hold time is deterministic and
> relatively short and no other sleeping locks are being acquired down the
> locking chain.
>
> I am afraid that the these criteria are not met. First of all in
> aer_inject_exit(), inject_lock is acquired while iterating the a linked list
> which can last for while depending on how many items are in the list. This
> may be OK as long as it is guaranteed the list will not be long. Another
> problem is that it call kfree() while holding the lock. kfree() will likely
> acquire another rt_spin_lock which is a sleeping lock. You will have to
> consider pulling kfree() out from the lock critical section.

The list length depends on how many error injections the user performs,
which is typically small since this feature is mainly used for development
and debugging purposes. So the list traversal time should be acceptable
in practice.

Yeah, pulling kfree() out from the lock critical section is right, I
will fix it in the next version.

> Another function __find_aer_error() which does list iteration is called
> while holding inject_lock. Again this may be a problem. If the linked list
> can be long, you may have to consider breaking inject_lock into 2 or more
> separate locks to guard different data.

As mentioned above, the list is usually short in typical use cases,
since error injection is mainly used for debugging or development
purposes. Perhaps we can also get some advice from the PCI folks.

Best regards,
Guangbo
