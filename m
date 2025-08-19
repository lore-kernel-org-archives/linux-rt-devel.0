Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5742EB854
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610112; cv=none; b=tdMfAEM7t39PfC7JaJudCQ2HxlUZFoylAoNB9fGNaSpBC2Zj2otOCwziisRAWAIKYsRcwbVbhGRXcE+b5FnBnu2BmD52GnbiKmpiH/PzOr4quQO6ctrKm+5ak1lXBUpHqG5nIr97JBZemJUHTcuu36TzckHQ20o9AJUOj9rz8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610112; c=relaxed/simple;
	bh=RQATp4q8jFSO/nmbkZjjBdQ3HZnpt8k+/cI/Qypg7A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP73Wpfm1sbRgYJ2zChyXS3YIObpsgNXUnLv0Gv3EkEIX8ILGg0gdHGkR1Yl0w5ObZJ/+52LdLxS59RzHAM2uNFW8Z7puFVQi1OfCir10oF1HMnIwIt9KZRppF2gohu9CFVYZ2avJ3hevIXSOuQ0Vmra2oG8/9AxhOsihxavaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKrNFRx7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zCz/KGuM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKrNFRx7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zCz/KGuM"
Date: Tue, 19 Aug 2025 15:28:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755610110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MeXOzsendUxuQ4IuOIM8nX/knNlVduf4YW9hRvOfMWY=;
	b=PKrNFRx7mebJvQkvNY7IhhNBfL+pizKLl9j0idYE+GaSRQ1OtdQCjGT1F3J4MZxrF2vPhM
	xiS9txEXxhz5uWEfRUiDjcCOhMRnuMXjgJfNAbCTN4I/vLtJzV+I3UPIP7pchQHFvHyNBn
	A36R1KrgCFImwWaL6lIAri1w26vcz4LpHVjitznWbLV3GEib9jePxl5MaY/ggFMa+FYKOw
	ed0RdMkktOq5JMUD/iPjFP+Pa3L/Vca6A0fBkNPiZtzknAkHwMm0Eq6TnGDLkS+P2PcNWs
	qnUxnJ5/TadZzfIu4DQBoQEqXQxKD3XSuhgg6ggU2v9Iv+6z7F40hpxTcJr12A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755610110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MeXOzsendUxuQ4IuOIM8nX/knNlVduf4YW9hRvOfMWY=;
	b=zCz/KGuMJ9apTB+DTRyUBQmNsM4Eeu0ivIDayRVotRLdI200Dss1hvjZ9I2i1J2GbbTITI
	0WnKtWbVf2yHRKDA==
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
Subject: Re: [PATCH v2 3/3] Documentation: Add real-time to core-api
Message-ID: <20250819132828.cs64VMsW@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-4-bigeasy@linutronix.de>
 <87seho8v12.fsf@trenco.lwn.net>
 <20250819080358.H9R_64I7@linutronix.de>
 <87ldnfv46n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldnfv46n.fsf@trenco.lwn.net>

On 2025-08-19 07:20:16 [-0600], Jonathan Corbet wrote:
> > Right now this is it. Do you update the text above as suggested or do
> > you want me to resend it?
> 
> I can apply it and make that tweak if you like, yes, no need to resend
> for that.

That would be lovely. Waiman did find something in 2/3 so there will be
either two tweaks or I resend it once Waiman is fine with it.

> Thanks,
> 
> jon

Sebastian
