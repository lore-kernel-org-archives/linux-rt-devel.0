Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B423433B3;
	Thu, 22 Jan 2026 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096890; cv=none; b=MXtdSiZhGlG9vTQlRl+Vf7Kt1CbfsMxh3RszNuM9On/Q+ceTNpbFGcvGvXCuJw+8C+BO8SgY7CHXm0WfvQBGYbRhXaXEnHgQxxTvwjRdWqP1xMo4ue3wc3fr2zzBt8GT25y51crnmRKezAoTtDeTAtGt1ErnDjUDCcfsQlpkJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096890; c=relaxed/simple;
	bh=frTBB73MtDuQNGKP1yVGyB3uz0vppSL5U6DQ3n2mzpU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RCqza3+Ekxun/dApVxY9Q/cbXbp1ptjPd5QaxWF/4vu8587djMa44NlvJH87tiZhc+2X/cAM1QApBmYAvsBoZswV+OJDe5rfMPZtWzufBjHeStMnXBIgdeZ3ZfRFTBJPD+v6q70+QRBMWMGm7rsCC57kWivr4xzPNkgLYAbxzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=l4QMB78b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="l4QMB78b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE7EC116C6;
	Thu, 22 Jan 2026 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769096888;
	bh=frTBB73MtDuQNGKP1yVGyB3uz0vppSL5U6DQ3n2mzpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l4QMB78bZ7KtXFeTJFMisjm/v2/Uhby2DQLmbJ6xYqFIETYhOZOrXz6c9LiasJWKf
	 ym8LbAzXoRVuRSqTeTyzJbDyqh+tl2SNPMBew9TzlkLero31X7O6FztQVEgqUXqRiY
	 iAeJUcBRMJO6HENvmZd+NbtHfoJtRmpk3Fn5WgdY=
Date: Thu, 22 Jan 2026 07:48:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND v3 00/10] mm: add and use vma_assert_stabilised()
 helper
Message-Id: <20260122074807.eccc6080b8d8ca5fc37b2a62@linux-foundation.org>
In-Reply-To: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 13:01:52 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Sometimes we wish to assert that a VMA is stable, that is - the VMA cannot
> be changed underneath us. This will be the case if EITHER the VMA lock or
> the mmap lock is held.
> 
> We already open-code this in two places - anon_vma_name() in mm/madvise.c
> and vma_flag_set_atomic() in include/linux/mm.h.
> 
> This series adds vma_assert_stablised() which abstract this can be used in
> these callsites instead.

Thanks, I added this to mm,git's mm-new branch.

It conflicts somewhat with your series "mm: add bitmap VMA flag helpers
and convert all mmap_prepare to use them".  I believe that a new
version of that series is in the works so I removed it instead of
attempting to fix things up.  Please lmk if I should attempt to perform
the repairs.

