Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A7A48B383
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910492; cv=none; b=kjdRBv2GTmmnVG6Y3KxWzlReuEaHu3GcEKbR6AN6SskH7k4t9ipArTbud3S2HeV59rg5gx38kL7TcyyTHL4txFCe8ZeU6vSGNOWIyW1y+ruyeokSNx3RzS/jHzkoSzealpKza17CeCmvdkmqRQNETEPVf28Yt70ZObh/UJzxm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910492; c=relaxed/simple;
	bh=vNqZ+wb5/76niQVKTN/W/XGroSs06KTMEKHwbzoPeCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUeUmKgQWpMNE4LhnCnN9ak7hbNn2MzqWWHVKNR5BU02FPc6MFZAieqUL2OkrjmKVjFrza9T7wzhJoZ/FCTwRYa8/qPi8XI/W4XVSb4O1TuvwOGOPPpsqfk26QI7WYU513ED1lrUY0yM/0aUM3E1nJK/frdO+INgGxlZnniI8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uVmyuIjq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+pXb2WmH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uVmyuIjq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+pXb2WmH"
Date: Wed, 1 Jul 2026 14:54:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782910488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNqZ+wb5/76niQVKTN/W/XGroSs06KTMEKHwbzoPeCI=;
	b=uVmyuIjqbGVbIhZMbmfI3AmhEG4X31txRt3y5bYp6htqBdnjkBTUf+QgT0IBqU1oPso3EO
	mThef4gqC9Pw1O7x9KkfF+lDp9WuYM0JUaNTOWvSN2yVBfmC373aIM3Af2slbeshjIsr9S
	fMGTPZQHtJwh60gfPq/UZjOXnTCyJHlUeiVJ14qD/Dq+vCJ/W8FwaphmKFNrPnHXehAzDx
	CfBSG1g/1KbU/j5SJp75D45kKk8l7FGUKnuY+O7mBzolUND6/XsZEYKLFchspXK6T+daf4
	dSbo/vZV4fqKKo6X5IET1m0MbJmVzDSENreNm6Xyf6PxeHkP8od6aihnbG8F+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782910488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNqZ+wb5/76niQVKTN/W/XGroSs06KTMEKHwbzoPeCI=;
	b=+pXb2WmHx/LNdlOM8szHY/9jRz/1yGewLWRMicleH4iLlRZuufZJQGg23LoprI9x0k/EqE
	rheUlFrPPMsT4qBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Bommarito <michael.bommarito@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] futex/requeue: Clean up requeue state on the
 self-deadlock path
Message-ID: <20260701125447.5Co4KrvI@linutronix.de>
References: <20260629020049.2082397-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629020049.2082397-1-michael.bommarito@gmail.com>

On 2026-06-28 22:00:49 [-0400], Michael Bommarito wrote:
> Fixes: 74e144274af3 ("futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-deadlock")

URGH. This should not have been merged in the first place.
Sending a revert in a bit.

Sebastian
