Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5991E9B1C
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Sep 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203299; cv=none; b=LhO/qa/9nbv4b07MlbUrxRgIHLte1gDNVjSE/icjbxBtCRMF7uKD2T8fg2iVhIX7ewvctc1r4MeW0fPIxRTOO1QYVBs3X9S5mq0jq6TbHamoGYHV0vRlsfHRbgGr8tqHXNDn7NoRmUSX/I7A4YMqP5z877EGvo7ro7yJIRSNtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203299; c=relaxed/simple;
	bh=lDadJAvyZmcx7PatuYxQJaBFZ0vOYRBOxKD7sc4NrxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=td1gYUNsb+KOpFcT2gW3dos9/GmDlF6myKFFPFTbJ5VcbctTGf2C8bW9r6XK/Up2UsdxWGC296yel+XuaYkqfEr3aMikbH2/ys0Og3LUyBMn2I1sucMTlnI/FP0Bj/s1jgdjDbhFS/QbXuybkc0p7vy7oqgr0WUCkGADMHi+mnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=xrQKWE+/; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="xrQKWE+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758203294;
	bh=gjZ4m8+fnvvBoHeOxGVUc9aElTf4Aye6ynvpcFh61TI=;
	h=From:Subject:Date:Message-ID;
	b=xrQKWE+/oRfsgdMImYSP+oz8uBnRGWcvcMXgr+V1T0J6whGqlgcQrcAr6WnvVg7se
	 k4dopYDs3XdY/9yD85cNhL2m8yf9UFXnf/mf4MNU+Oly9KEH3vPI4UwYCbc09h2C9w
	 0iuKxtT9ynN/jMTgiS7ynYiIW5HRT5ogD32+Gfq4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68CC0D910000565D; Thu, 18 Sep 2025 21:48:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8010254456942
X-SMAIL-UIID: 9B565D5A1764478DAB38227F3EE49FFB-20250918-214802-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/3] softirq: Provide a handshake for canceling tasklets via polling
Date: Thu, 18 Sep 2025 21:47:52 +0800
Message-ID: <20250918134753.7122-1-hdanton@sina.com>
In-Reply-To: <20250915073933.L7UOtfkj@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 09:39:33 +0200 Sebastian Andrzej Siewior wrote:
>On 2025-09-05 18:15:01 [+0800], Hillf Danton wrote:
>> 	CPU0			CPU1
>> 	----			----
>> 	lock A
>> 				tasklet C callback
>> 				lock A
>> 	cancel tasklet B
>> 	DEADLOCK-01
>> 
>> After this work could DEADLOCK-01 be triggered, given no chance for DEADLOCK-02 ?
>> 
>> 	CPU2			CPU3
>> 	----			----
>> 	lock A
>> 				timer C callback
>> 				lock A
>> 	timer_delete_sync(timer B)
>> 	DEADLOCK-02
>
> You are not supposed to acquire the lock, that is also acquired in the
> callback, while canceling the timer/ tasklet.
> Tell me please, how is this relevant?
> 
> If lock A is acquired on CPU0/ 2 then tasklet/ timer on CPU1/ 3 can't
> make progress. Now CPU0/ 2 waits for the callback to complete. This
> deadlocks as of today regardless of PREEMPT_RT and this change.
> 
In case of !RT, the chance for DEADLOCK-02 is zero because deadlock is
detected based on per-timer instead of per-cpu.

> The difference is that !RT requires two CPU for this to happen while RT
> is efficient and can trigger this with just one CPU.

In case of RT OTOH, false positive deadlock could be triggered because
canceling taskletB has nothing to do with the callback of taskletC.

In short I am highlighting the gap between per-timer/tasklet and per-cpu.
