Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE233A711
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Jun 2026 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303418; cv=none; b=AMYPDDnQ4+UBCM4UvDVPMGdHErNyFOXMv4YOmq9bqLOzAIsX7ki1pIcNWGfHIYOLLhUAVx0l/SViOPfk/6Ex+SVYuro79GFFe8LLKIT0dRsITLBBWYmuOFKsd9BG6ZrDPRjVVZWlxyZN3F9ErTZtVcx1Br1HerwsvTagA4nmhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303418; c=relaxed/simple;
	bh=or9nrt/sPpOrifgqe7xgdI64YKZfFojouqDdHaYNLgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idtWyxUa+ETf/jM0cIIur5SChuVCWzRNhHQKQo+4lS3/wCP9qPSTLPybQIZ3JezDR5oJTNyunmj3pmRVt+pTzdIrvmmmu2Hru1tvwLDVj8+RQEMEEQSljBzS0GfQNYhzVr3kmfj7GZXjNQiw71ynCKu9rChMSq6SpcZQD5JhGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAI8b1eB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XshoOjaE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAI8b1eB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XshoOjaE"
Date: Mon, 1 Jun 2026 10:43:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780303414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=or9nrt/sPpOrifgqe7xgdI64YKZfFojouqDdHaYNLgk=;
	b=hAI8b1eB7F7N1IxJojvddUnoROaDe3EA9dHJW4Acf/LJSnSDn4qcNiEuj9cCWcPhjqYLkJ
	3Rlo3A2sXDASwS8qAy1keNm7LKglh0CUPR8zgUuHfUbNNYTdWwppT21DiA9jGlElo/gJN2
	iScxRMb/1gXlyzUOOym4T+acRNRqGWkR84U3mrvuClpMMFJe0XCKSqSX4rRptVrSNpKZYo
	KJ/TJjE5d2JrtYjf9HDEYGX2bkZZJBkhkP6OiLHuLyngIW/SFxaWXbgouXYvHB6sn/8Lm3
	xdhlgzMsCdAXxuPVh0S/AmUPIhySPyPnONxmHdf3yiW7/MNP7FACNZCSJiJo1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780303414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=or9nrt/sPpOrifgqe7xgdI64YKZfFojouqDdHaYNLgk=;
	b=XshoOjaERE5oDCpD0i+1HdJpqcFNRW0GtPFzCQ0i/vRWjRYjBDcYwouSi+FXP1bEnbJRb1
	ExhTpi0zaWsBh2Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 0/2] lockdep/selftests: Restore PREEMPT_RT task state
Message-ID: <20260601084332.L2C5qF0q@linutronix.de>
References: <20260523185123.17482-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260523185123.17482-1-kmehltretter@gmail.com>

On 2026-05-23 20:51:21 [+0200], Karl Mehltretter wrote:
> Hi,
>=20
> the lockdep selftests deliberately run broken locking patterns. On
> PREEMPT_RT, some of those paths also leave task-local RT state behind, and
> dotest() has to restore that state before the next testcase.
=E2=80=A6

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
