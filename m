Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2929B8D0
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Feb 2026 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519629; cv=none; b=gqA/2JqIqQg66aTR2QtaTNfjQAiAZqJ8N1jxZ5r2p/yVNxKENH/0HKMiJHO5lm81fZTekQK+Kw2dIxIRK4Kc2Ip5Fzl0tSKepDD+M3d7DMbeRh9mieEdGKirzOemwOZgy5mjGTPh197R+FPJpSbiw05zpO1VNGB/joM+caruj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519629; c=relaxed/simple;
	bh=68WV0bnkyGMG4Fz3gvwEf8K1zfssaW5iUBDg8e3iUXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb5iGhVWRuw3h2lgmnL2a2NDg8wIatYM6tH6c43co6DxCiSGp9W097L9FvmAgr8BTTA6l2qGZdDSc37wubZjXjUB7ktM6W3YUjHvrOEuIkUpafduCvfOQVu+w5SUId9cyvey9jrUH/TUAtFs5oz3G1G9WDtsD84xY8YlSrRw/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=QQlq2MjV; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="QQlq2MjV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771519611; x=1772124411; i=spasswolf@web.de;
	bh=1H8fr30scMncespUQppfrn3xMDdgzyhFlSQGZ07AqJE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QQlq2MjVlVoPwCADwOH1PHZQrQy9kK+7T9J2Rv7VPDWzcRQFEQSVuSQZ8vlqVbX1
	 gwhDfzK4vapsBfAvgQkrwP7PntUUcRnot5gvQ/jPUAM0/d2LqyQLJscD8hpfXaxUh
	 pcIgySbOPcTpvvXKc5R+WQaXcp1TsU2bz+vbGmcrRcgwDFq52Ujs2C69WAoSaKgpm
	 BG8X8Z61XhzhgzhzL+fn+i6D69LrY/xSB0/EKQeLV8Gg6FE6RzoyNrVTP2yOCIXwm
	 Sa+T57mXJpHGrRU1JRAFw6Ps1R9mzOvB33brJ50SFAaEa27S24vn6aRnmjyqIQptS
	 N0QBbkUS511/4iOiwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N2jWI-1vlZfb1VAC-00z2ps; Thu, 19 Feb 2026 17:46:51 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Tejun Heo <tj@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	calvin@wbinvd.org,
	dschatzberg@meta.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: ~90s reboot delay with v6.19 and PREEMPT_RT
Date: Thu, 19 Feb 2026 17:46:47 +0100
Message-ID: <20260219164648.3014-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1upwbBpQsXdSpVpry208YxqKiclRSvNT44NmQd6fzUmgiKROgNq
 Mk0HKp0rUFy4shSU4O8urekCf2h5B8pn8jBZsAtvKUZiN7ne9R0Tz+//0uzrZ0kC7I+Ptx7
 VPAK+oet56qenk1eqFrHGv4uKqWHz307BJ/bQapQxO9f85fblQnBW1DrcA6aATNCUxTmc2A
 3lBUDIKxoUDKM6QYSZujw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VhJ8yTEIeZE=;9bMvBXgtOvg+Q1cthULGIKV9eOV
 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
 P4RhKaQtLRsJ8gHNT588u8LS0t5XaWheHmSEDz

Since linux v6.19 I noticed that rebooting my MSI Alpha 15 Laptop
would hang for about ~90s before rebooting. I bisected this (from
v6.18 to v6.19) and got this as the first bad commit:
9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PREEMPT_RT")

Reverting this commit fixes the reboot delay but introduces these error (which
also seem to make the system crash sometimes):
[    T0] BUG: scheduling while atomic: swapper/0/0/0x00000002

Compiling the kernel without PREEMPT_RT also fixes the issue.

I've test these commits from "git log --oneline v6.19 kernel/cgroup"

This commit shows the reboot delay:
9311e6c29b34 cgroup: Fix sleeping from invalid context warning on PREEMPT_RT
These commits show no reboot delay, but "scheduling while atomic" warnings
and instability:
be04e96ba911 cgroup/cpuset: Globally track isolated_cpus update
b1034a690129 cgroup/cpuset: Ensure domain isolated CPUs stay in root or isolated partition
6cfeddbf4ade cgroup/cpuset: Move up prstate_housekeeping_conflict() helper
103b08709e8a cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping
55939cf28a48 cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_isolation_cpumasks()
b66c7af4d86d cgroup: use credential guards in cgroup_attach_permissions()
d245698d727a cgroup: Defer task cgroup unlink until after the task is done switching out
This commit shows neither the reboot delay nor the "scheduling while atomic" problem:
260fbcb92bbe cgroup: Move dying_tasks cleanup from cgroup_task_release() to cgroup_task_free()

Bert Karwatzki


