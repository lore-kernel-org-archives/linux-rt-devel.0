Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B8267AFF;
	Tue, 11 Feb 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316261; cv=none; b=uHuJC7cUdQoEbGBa/CCRCEgADZ5UuAiK44xCfsABnAfIfT98IsSgpqjd2UXMU8EUFAZGBCh5YeSeXaGiJ1AK1d4wFHRQaAdjQvAo7WjXDUQ4kAX3KxF7X98ExWxWRDpBcNOv2hw3TXBhz7G8jc2Ca060eOW0+DlCtTJPKVf/MnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316261; c=relaxed/simple;
	bh=muvOlV0gp+wkReTCX7K5Y3cgTnjMat2g30jAQQ1Y5z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqVGdjTGNDl8iE8FbSwpJuj9bDgd348JW+UshvUkQ/KRcgQaVQbeI2rcIPBKdJaaeWhztaGo3ZtbMwKGpWs9EQf4lSKeztBJFHoHHw/8mqkzjQSKAtbmBbjtfiZwv15m7CJTsFZCEMR46nYe7NH8mMD3rl/zY84b5xWhRBCrVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEC7C4CEDD;
	Tue, 11 Feb 2025 23:24:19 +0000 (UTC)
Date: Tue, 11 Feb 2025 18:24:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey
 Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Nico Pache
 <npache@redhat.com>
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
Message-ID: <20250211182425.01cf9a01@gandalf.local.home>
In-Reply-To: <20250211145730.5ff45281943b5b044208372c@linux-foundation.org>
References: <20250211160750.1301353-1-longman@redhat.com>
	<20250211145730.5ff45281943b5b044208372c@linux-foundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 14:57:30 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> I'm thinking we add
> 
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> Cc: <stable@vger.kernel.org>
> 
> but c056a364e954 is 3 years old and I don't think we care about -rt in
> such old kernels.  Thoughts?

We still support -rt in older kernels back to 5.4, and we merge in stable
releases. If this fixes an -rt issue, please do mark it for stable.

Thanks,

-- Steve
