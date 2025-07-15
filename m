Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86E26281
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591335; cv=none; b=bvtXGKfy1rQU3pTAMnJiwzk1IWk9VXJdQEByK2BCxmE0VyLPc/03sMupciuFuitG5rQ9Pn2u1u+5BJ6iP2uVLIhwK5tNvE95qsybTKhqnvnOjU17ZeIeLAXBaFu0vUk97jvZ6NdVyyEBMwdFXAWsRjgnuK/lQjzzSE3pm167TYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591335; c=relaxed/simple;
	bh=HngQSBN6EYgWlWEconlHPxoRXQuQunnOYOhmdluNvvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3tZsKh00rO1C3jbriRYDSe2bmf4mKwZx7T9faV94EnfUM+I74uof2I8+T1oTprsMaUe4LwAzBf34IuTMKIKx2R8BH6fs7VsCfIK6y6J0oSDeQ5twQgF4cEgYQH9HMfLP6HRFM7Cf+1ykcuK8Z3Z8xAFKNpJyO2mKR9q21T6MN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QYddt5gD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=563mM4cB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYddt5gD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="563mM4cB"
Date: Tue, 15 Jul 2025 16:55:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752591331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esBDBDN6FlIpvsUWf9eWcBpSKBzPnHD4m7HtXZDxmbc=;
	b=QYddt5gDCDXsNMEV8LYL6KmUhZ22HlFpjxaqDwhCsyD6vucxTOFAJgQyEtSL5M6s3MdMfW
	5MgBas+VSKOVZmJVqgcVA3bGErbu5ed5lupCYi9QRgWC5ohATv3tLrNue8Ya5MDJNQlxDv
	Wu0Dx8RYk/aAfXjqkAFnyav+inW68Bjn/tATeTQNa+wA/YCym8hgqSDltotdo2oxHHFJFm
	8JVRYUL/IyfP5tkaAhKevgO/QMoVDh1FPZFKrPYWrGlkcfcJV49YJKG7JwpizihilUs0cv
	ez07IsgKN61UrxHptUzwWQLH/ruiXAm9ubq+GUMIRj5NzZjla3X4uYkLmGv4rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752591331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esBDBDN6FlIpvsUWf9eWcBpSKBzPnHD4m7HtXZDxmbc=;
	b=563mM4cBcMoIGVh434KmQp+HmWsN9BMkuaM32b7AQ3woUpyBfQhYxtQeJfikZn/reASLfM
	SigdlmGBLGbAX0Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] Documentation: Add real-time
Message-ID: <20250715145530.eAiJbEiG@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
 <20250715144127.697787-4-bigeasy@linutronix.de>
 <87ecuhh5jr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecuhh5jr.fsf@trenco.lwn.net>

On 2025-07-15 08:50:16 [-0600], Jonathan Corbet wrote:
> > diff --git a/Documentation/real-time/differences.rst b/Documentation/real-time/differences.rst
> > new file mode 100644
> > index 0000000000000..0b9a46a7badf4
> > --- /dev/null
> > +++ b/Documentation/real-time/differences.rst
> > @@ -0,0 +1,244 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +.. _real_time_differences:
> 
> Here, too, you don't need this label, especially since you never
> reference it.

Okay.

> I'll try to have a more substantive look shortly.

Thank you.

> Thanks,
> 
> jon

Sebastian
