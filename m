Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D420A5DC;
	Thu, 13 Feb 2025 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436785; cv=none; b=Ze02bg30oSd4JTeQtZ3rM/GTJ3On1xB/02+WDEkKy0Lpmwgrc55a3W/xWGf6AllUhk7l+2X29dniMrJqxW8pGKJ2KxhE95K0HNWn0zqg0nPlEtXGNjXcxfN3U8X+F5PiJA5GHaMPqDdJlWnWV9NBWc6+B52zwpIhA6N9CNBam2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436785; c=relaxed/simple;
	bh=WKFQg0tUpD0V4K3NRekMqZhxeN3j1nUw2yKI1wbW/b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFi3Mn9Lq8mud2Ql0Mcfl9kzaP06K/0hqKasWTqAWWjBji+kHkMpX7VR/gWyqH0WPi7B0hrk2+m8dT9VDOwIGByV5JciTXnFWm0TdehzEVRzF+HbqwueM07ciRqJZtE8WTHk6LkSILSY01Gsi7HBEr4Ryu7WRzkFcu/uoQjWj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nF80/H3e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5+DfNGw9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nF80/H3e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5+DfNGw9"
Date: Thu, 13 Feb 2025 09:52:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739436777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jj7WmyJALGlmD3SK+Lf26YBTxb3qNskOoxQ9euTth9w=;
	b=nF80/H3eTjxlDF+kwC24OsErHpxo6MLY5dVj8+HnI7D+j334Wki0GCqPG0qAnwIgwMT1CV
	w5WPPpsZqqWci65SM+hHezXYEaEXlqcJ4geuHHe7xN51AWoEe1GpOVL8Z0u4gCtsnZZvhM
	vZdx+VlR2MKARL6XhmJCjTgFQi3F5+ZuY4HzxIyQAiAZZ3HPziaH0OjqVXuXPVgNMUdmHk
	sy9QZngWbt2C0bgccYjkHaCSH2tXQENphfyvLO3b1UH5YF899GUsZNHl9jUivCxwBylGtQ
	vFfrlt9xM0mAIccJVyTyBlCGl3lOeBLmK6vDBZuhj3gdoeDvfO8l2mpKYlpHTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739436777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jj7WmyJALGlmD3SK+Lf26YBTxb3qNskOoxQ9euTth9w=;
	b=5+DfNGw9kopsvR/OGQwCZoDcNHE8k5d4/0dyHAsxQloPZlzpcbdjrA16m0lHebiyfqVYgx
	eObSeqZh+HVdvjBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gustavo Padovan <gus@collabora.com>
Cc: kernelci <kernelci@lists.linux.dev>,
	linux-rt-devel <linux-rt-devel@lists.linux.dev>,
	stable-rt <stable-rt@vger.kernel.org>,
	Daniel Wagner <wagi@monom.org>
Subject: Re: PREEMPT_RT testing on kernelci
Message-ID: <20250213085256.nhWptGL3@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
 <20250211152018.sK91dh93@linutronix.de>
 <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>

On 2025-02-11 12:50:47 [-0300], Gustavo Padovan wrote:
> Hi Sebastian,
Hi Gustavo,

> That is one the current limitations in the dashboard. The CI systems are not sending
> a clear signal yet that they completed all tests they wanted to run. They just submit
> test result individually as they get finished. 
> 
> Imo, it is a priority to fix this as it is second time this week I get this feedback.

Ah okay. No need to rush. If you have something to look at, let me know
and I will. Other than that I will lean back and wait for the bot to
complain ;)

Thank you.

> Best,
> 
> - Gus

Sebastian
