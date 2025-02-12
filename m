Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB36BE67;
	Wed, 12 Feb 2025 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319621; cv=none; b=TQsgjCB+w2J8RMjl0pGgGZLI3UwZw+a8fn44sT6aZyxJBeyogD4BVkjN+CVrpUTo76xGzHze7nUq1p2Fe9C2JJHMq+3cB7GrhHftdD95hocIIPSScWTLOLObVzRCdJC6qfel+84vF6u05UUIWomJPP1RXQRz/rngc77okiFCd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319621; c=relaxed/simple;
	bh=BtuxlAOOOmC1OFw0stn9/nKBeUDE+lLkdCQMkEuVWHw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZbXgFPOwRtOba83/pO/Wel9e6lwug2w3Bw2fAceEOsZVaEmUBVmPti/X9wYdH5GgA2DP+cszIouHFE6bj7Pew1DqHbgeoWyzSqRzJH7JtZfnEkTjmYiRVi9cowf2e8JFjtRbZwFG6rpeRm6IQQO7rfxo4wr6cMQ2Px9UJQ5Z6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=18yKYkzu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="18yKYkzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548A4C4CEDD;
	Wed, 12 Feb 2025 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739319620;
	bh=BtuxlAOOOmC1OFw0stn9/nKBeUDE+lLkdCQMkEuVWHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=18yKYkzu43VqoVgu0pI/83Op9WSK3ScYp+8FSRpV7CKnaNzBR1+bkbyBsNyBzg2ps
	 Mzrc3O2GGuM69uLRauh4x44mIScPUzMnYEIBrFaguj2dF3OFsVFIDO3CB4+vCy6c5g
	 SeyoXwR92NOKpjDHnazSgH7cyB4YwuGUiI5U6bJs=
Date: Tue, 11 Feb 2025 16:20:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <llong@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Nico Pache
 <npache@redhat.com>
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
Message-Id: <20250211162019.c2ce0583060cedbd5db199e5@linux-foundation.org>
In-Reply-To: <6b6c1245-f6ee-4af7-b463-e8b6da60c661@redhat.com>
References: <20250211160750.1301353-1-longman@redhat.com>
	<20250211145730.5ff45281943b5b044208372c@linux-foundation.org>
	<6b6c1245-f6ee-4af7-b463-e8b6da60c661@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 19:16:34 -0500 Waiman Long <llong@redhat.com> wrote:

> > Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> > Cc: <stable@vger.kernel.org>
> >
> > but c056a364e954 is 3 years old and I don't think we care about -rt in
> > such old kernels.  Thoughts?
> 
> The KASAN report_lock was changed to a raw_spinlock_t in v6.13 kernel 
> with commit e30a0361b851 ("kasan: make report_lock a raw spinlock") to 
> fix a similar RT problem. The report_lock is acquired before calling 
> print_address_description(). Before commit e30a0361b851, this 
> find_vm_area() is a secondary issue. We may consider commit e30a0361b851 
> isn't complete and this is a fix for that.

Great, thanks, updated...
