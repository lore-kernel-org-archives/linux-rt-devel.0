Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925A3815E3;
	Wed,  1 Jul 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933205; cv=none; b=VHrTv+OBdplNm3K5Q4ijd56Z7hGS0wXeBo5V/mysNTZwHJcLuUPCT1UcCOxKPjXEpb2k279hPiDjPsX3/esRqESsjpkvk+3hXuicoT0ySSn08phlXkes1BGlkHJiPaN7Rp+OIBZq6z4vbdKp3KN7JXkNJLtaOk4pn/cw4LnD62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933205; c=relaxed/simple;
	bh=/rWMGVrByHE8TOt8M64j9dhfvBrJHJHQN5F5Prf7JQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dDxZElJ/egm/Iyra/vWs9sHTkvjyPMlEb8rMAmmALEu9xZo5wLNRd7KOxlWxk94WRqoWMSFx7MsIzmIMdq/UMJL9r9sxIUekT+Z8KHqhXR0TmukX9N3F9xSZI1kR9TzyD0TcyWjSaK9MonasgTswe2kaP4dEyISKinIKeVGYSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUGHSXR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUGHSXR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC5A1F000E9;
	Wed,  1 Jul 2026 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782933204;
	bh=BcQkRe6SWQQ8OEXvMM6/AbmBilq7Gg1B0Taf8zuAgY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mUGHSXR5bZZhNY/VCh9expqvai3wh+Rw4yj+r3KMctEcWFnoKOrEtwwqbXyvx39KN
	 hC2sbbm5lN/0ilj1cSK9hCssra9VsZH0LAvBvZWpwFPHgtH0AjnQyyFCI93rC4zIxt
	 oeWk884xJAhoZspPvkLvZW9OoBl54EFsXvG+BU3giRWJ1f+s3FksUI6ovUf705aei7
	 x5XlRxGDvrqTpb7WG6DPtEiSWVpits/t2ejFJmL4HflXXAI05Wj4yW07BlyHM7CHSt
	 TFwaVE0XmHravndvtOlEDy/55uD6DJO3n1EiLKF+rgNrdVFmnihxOG15iTZFb5YqxN
	 HcdSx0ncJz5VQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren
 Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?=
 Almeida <andrealmeid@igalia.com>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ji'an Zhou
 <eilaimemedsnaimel@gmail.com>, Michael Bommarito
 <michael.bommarito@gmail.com>
Subject: Re: [PATCH] futex/requeue: Revert "Prevent NULL pointer dereference
 in remove_waiter() on self-deadlock""
In-Reply-To: <20260701154517.0u_G4dkO@linutronix.de>
References: <20260701131150.0Ijhq4Dw@linutronix.de> <87h5mipwa6.ffs@fw13>
 <20260701154517.0u_G4dkO@linutronix.de>
Date: Wed, 01 Jul 2026 21:13:21 +0200
Message-ID: <87echmplpq.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 01 2026 at 17:45, Sebastian Andrzej Siewior wrote:

> On 2026-07-01 17:25:05 [+0200], Thomas Gleixner wrote:
>> > That has been already handled by Davidlohr in commit 40a25d59e85b3
>> > ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")
>> > and requires no further acting.
>> 
>> No. If the self deadlock is obvious, then this should not even go into
>> the proxy lock code. I clearly failed to notice the leak problem, but
>> reverting it and relying on some magic down the road to handle it
>> correctly is not really solid.
>
> Davidlohr fixed the issue that has been fixed again. We don't need two
> changes for the same thing.

He hardened the remove() function against that scenario.

> We have deadlock detection down the road, why special case it here?

It's not special, but there is no point to actucally call into complex
and as demonstrated fragile code when you can avoid it upfront, no?

