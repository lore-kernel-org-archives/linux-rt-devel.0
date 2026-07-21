Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5CD39EF16
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649125; cv=none; b=HLSZGoBJ5pxnsscpw8M3135FmmkXZ2XHcQwZVGn+47T+ciXAFLT4al+s0RRIivyFvnSpYaeIBVmfmQST4aLZWYAiucBxwZ04t8YPojm7w3JXDgtKor2Hk00HY9yb/WcxeOMCcmhEnuVFsVUC+g+gWIPz+U/8VukJwAVNtXVfjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649125; c=relaxed/simple;
	bh=BOJNFKFHPMWMqW4Cyo7goHnFS8Qn+Tk2Jz5ToPhtb04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6UWT1yuGTlPOEiHhop/JvjfCc7qk/hU8tqjIqDKj1Uyu6r4CyuWi/HB8ba+8zOY39msIe8+32qdyqJJQeB22f/USKWVYKTbNnwTuHrAz1XBytbIr1GjfGgBS1aL/1t9j8cVkUDHX5r5z1cQhTU10PlPNp1Mz731L7h5B37j0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dOrr7k/g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKHiXfPP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dOrr7k/g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKHiXfPP"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784649120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7xMNVgyGGRyIJjpXA89R9vggcnCwn9+jkC/W3//MNU=;
	b=dOrr7k/gCpLEdMnv5dh35arkpybcWD8kCUht22t5gObuAZatCP4xhAVQjic61E2sFQzQ2S
	MqnoA75VFM1bMW+XlwG3nlOEbc2hUVjI8SHCBzMyHvrPYmwmSnEhgsqzB1Xeb5fbIRk8ag
	wKQH4iMhw6tZZmHxW64h3uQlPOB+m/uYM70sxuTXYZc3DjO0/Y6auycLAy0ENtYgtqcmkf
	IVML1bKkoEiVsQtZMBaZzWruMTy2HjS0cnRHK8BljUXFtAh7z1rcLe9zIXCm6D1U5h7Yoy
	jPh3D8HQsgywlzOaX/g5SvLVD/Bz/K4JICySxHnha5gTpj4A92mVqnWgBYgyow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784649120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U7xMNVgyGGRyIJjpXA89R9vggcnCwn9+jkC/W3//MNU=;
	b=lKHiXfPPd51EAGFq8GJ65zypWRA5lifGz5wyKa132AFkAABV3p1zQWIB7r9k7FImJRLy4W
	uOpCMsOhbXf0K0DQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Jonathan Corbet
 <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
 Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
In-Reply-To: <20260721152114.wTED4bR5@linutronix.de>
References: <20260716195716.256025-1-darwi@linutronix.de>
 <20260716195716.256025-2-darwi@linutronix.de>
 <20260721130248.ndwsFtHE@linutronix.de>
 <874ihs5s4d.fsf@jogness.linutronix.de>
 <20260721143606.NqT15H0p@linutronix.de>
 <20260721104806.64afcd8f@gandalf.local.home>
 <20260721152114.wTED4bR5@linutronix.de>
Date: Tue, 21 Jul 2026 17:58:00 +0206
Message-ID: <87wluo49y7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-07-21, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2026-07-21 10:48:06 [-0400], Steven Rostedt wrote:
>> On Tue, 21 Jul 2026 16:36:06 +0200
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> 
>>>> Unfortunately, debugfs is needed to configure the fair deadline server:
>>>> 
>>>>     /sys/kernel/debug/sched/fair_server/cpu*/runtime  
>>> 
>>> So drop the reference to it. It is not "bad" to have it enabled. It is
>> 
>> I believe that some distros feel that it is bad to enable because there's
>> no real auditing of its interface. Although, it is now only accessible by
>> root.
>
> Yeah. Either way, there shouldn't be anything real-time specific that
> requires the user have it enabled or disabled.

The fair deadline server is certainly real-time specific. It is the
new/additional RT throttling mechanism. Generally speaking, RT systems
will want to disable it or at least reduce the 50ms default.

This document is not about runtime settings, but if debugfs is not
enabled, the user will have no way to configure the fair deadline server
at runtime.

I am OK if it is completely dropped from this document. But if there are
distros that think it is bad, it might be worth mentioning that this
config is important (if not critical) for real-time systems.

John
