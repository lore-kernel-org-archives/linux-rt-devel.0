Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5622AE65
	for <linux-rt-devel@lists.linux.dev>; Tue, 18 Feb 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866274; cv=none; b=mnmlRSovPeCJN0H0Jb7I1imiZlFTJ/LMXFA84IK54jhtP4+wYiP1xbtDcEY317dThbcfXS3K6K0JzpMWunK8embUFar+IfRGcWl0Z3/szzhnojLYZXVjhHCMwuPxNuk9jwFGdX/KUWkmVmfh/T3SK96rX4qQX8o05WrdTHqsjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866274; c=relaxed/simple;
	bh=sMyD5WghmQkPvsBnt8DB05/niNVQXB+q56W3spPtS8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9KglXiXRCAm32ZQV6dO19rDSwzQiI5kA5VAFf8vtvj76D/dfLRB+76f3Z8MVh5eb5D0RRiof1aQxlK6k711vTudGowsM3q+gEhA55i+hkbk9OVNM7kFwGqOuQDnlla+5p673TAI00iJx2iZ1/ZoI3ZBWtRTuuFbKgkfGKw6ERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FBPd4RUa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BftFmJ+D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FBPd4RUa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BftFmJ+D"
Date: Tue, 18 Feb 2025 09:11:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMyD5WghmQkPvsBnt8DB05/niNVQXB+q56W3spPtS8U=;
	b=FBPd4RUa4dPnYHRnJWsoa2szcs4AWOdIFdm7A3EDEDEhxql+Xguo1uhjhhXYKyHyPsWqRc
	5AauyORi/ZPNt6MtV5ZXYcFanWNzFL5g1mZTWFK5iT49pdrYlwe1JeUK0cdsLu7w2UDop5
	8Zsvj5tGxoxpAHhEWGxYQHSXMLcnMAfamWZH+VwKV+mptUpuK6ItYzPi9QLjUWI2dw8EF/
	HcHOeN3eRn8JMFqiYwXgD2XV2juVpl0fryzPTt1J2plMYymsfyDp6IGTeOxGYX9kGbISz6
	UZGMaLQuANy4Wlrbqezb4Ta6tXHE0z4m+7G+6AAbr7zucbuTGROEFwl4pLPeoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMyD5WghmQkPvsBnt8DB05/niNVQXB+q56W3spPtS8U=;
	b=BftFmJ+DlYsBMqvagP//ConIXq0lavqv4rZXbYwqyHEgTxu27y8BDI56xFc9R44+FnMQgJ
	w+kQzUuwTkQMhaDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v4] kasan: Don't call find_vm_area() in a PREEMPT_RT
 kernel
Message-ID: <20250218081109.Hz-r4tkL@linutronix.de>
References: <20250217204402.60533-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217204402.60533-1-longman@redhat.com>

On 2025-02-17 15:44:02 [-0500], Waiman Long wrote:
> The following bug report was found when running a PREEMPT_RT debug kernel.

Thank you.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
