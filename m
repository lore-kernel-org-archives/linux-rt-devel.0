Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396A262A6
	for <linux-rt-devel@lists.linux.dev>; Sat, 20 Sep 2025 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332345; cv=none; b=RLGkMAR25lFekCWucHjJUydr3HqSNg5AtWr5iusMvjdpAP9P2LPMI4JU8Bkd2a0gFAAYrw2W8TfweBopwnCuuA8UoqRmT3gKCX65dPQKizDWqvPshl/JEXBPfM3IHuB6jNMPREnhdjp6Koosm2pvikXzUiCP/W3dMyAL/dNa2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332345; c=relaxed/simple;
	bh=4oUJ8fRFafzx6n0VbAgR32rVfDk9eWcgIP62WggzIvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtxHN9odPA4vbA7ByIB/riCbNkI5WIDd7DkAe0YjYMD2dbbuSwIzOVqvIP1Qx0Y1YzM2dYTBOhH5yZ1iR6QlEzojbLaJVs7n13BQ13+hLaW50GD287b4n12Fi7bb4EI6lAIAmD6LZyxXKacBSocHLHXpWUFswa9ikLYIHdCzkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=d+Pb8gbo; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="d+Pb8gbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758332339;
	bh=fUJNDiMq/A590ogHAMfnSIouICh5WTLGefNsmeO014Y=;
	h=From:Subject:Date:Message-ID;
	b=d+Pb8gboWMWjxq+9Smrd3Ot36qXqdc/T0mZXR1EMyZuz+7vpdSmmstEy3uP1Um+cJ
	 RWvACsBOMOCncuigskQMDZ8l45BrGYBHH10DPlxo1sdh2o5DiRvI388GGz/P8lX8U4
	 OeP6L9K1Ih7VPudMK8ATYZuV5zql6wR8littPGsw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68CE036D00007AC2; Sat, 20 Sep 2025 09:29:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8097736816550
X-SMAIL-UIID: F782A7B096BA4B95B0DAEB1B212773C2-20250920-092919-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/3] softirq: Provide a handshake for canceling tasklets via polling
Date: Sat, 20 Sep 2025 09:29:07 +0800
Message-ID: <20250920012910.7265-1-hdanton@sina.com>
In-Reply-To: <20250918154937.RQqkeYxI@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 17:49:37 +0200 Sebastian Andrzej Siewior wrote:
>On 2025-09-18 21:47:52 [+0800], Hillf Danton wrote:
>> On Mon, 15 Sep 2025 09:39:33 +0200 Sebastian Andrzej Siewior wrote:
>> >On 2025-09-05 18:15:01 [+0800], Hillf Danton wrote:
>> >> 	CPU0			CPU1
>> >> 	----			----
>> >> 	lock A
>> >> 				tasklet C callback
>> >> 				lock A
>> >> 	cancel tasklet B
>> >> 	DEADLOCK-01
>> >> 
>> >> After this work could DEADLOCK-01 be triggered, given no chance for DEADLOCK-02 ?
>> >> 
>> >> 	CPU2			CPU3
>> >> 	----			----
>> >> 	lock A
>> >> 				timer C callback
>> >> 				lock A
>> >> 	timer_delete_sync(timer B)
>> >> 	DEADLOCK-02
>> >
>> > You are not supposed to acquire the lock, that is also acquired in the
>> > callback, while canceling the timer/ tasklet.
>> > Tell me please, how is this relevant?
>> > 
>> > If lock A is acquired on CPU0/ 2 then tasklet/ timer on CPU1/ 3 can't
>> > make progress. Now CPU0/ 2 waits for the callback to complete. This
>> > deadlocks as of today regardless of PREEMPT_RT and this change.
>> > 
>> In case of !RT, the chance for DEADLOCK-02 is zero because deadlock is
>> detected based on per-timer instead of per-cpu.
>
> But your "lock A" is global, isn't it?
>
IIUC whether lockA is global can be safely ignored here. DEADLOCK-02 can not
be detected with !RT because by define the callback of timerB has nothing to
do with timerC in addition to the current per-timer detecting mechanism.

This work however adds per-cpu detecting mechanism that fails to tell the
difference between timerB and timerC, thus false positive result comes. For
example the callback of timerB does not acquire lockA.
