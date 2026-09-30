Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E536920D
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737171; cv=none; b=om7QM7H48ADOQMDPThf9xTeFaT3j89ItjPasJkt7+b4zicvi58x3eyyBnFdNKRYssJEJlkTHnvy1BhVp4ynvbIGBvo3Ms6ZVFMnxY4C0B4XtNyn+52VDd88secPr022M3XROq52eKzyEA2+JE0v8AV7FF9JkYDIDmB1JfHATfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737171; c=relaxed/simple;
	bh=jryVeyCE3ENwhs5+JjIDYwN2HfxA07BwvfI8E+aZm4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvdLyvmFYdtSfvb+7FbHvYV8p9bt48TuLf6ismdlzwkJZC5z8B/edU1C2FY82dmINXRSGg5LjSEmhVQjBO8sZfXSIOrqBqg8Cx9qsBFRDNelzmylLDVxZf42N4g8Q1USxFzFu0syoe8NiIQMz0n6tHDmTnRz5j2hlH3swtpXxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UmwSPjcN; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UmwSPjcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ci
	H9O6vBnrQUkYEAwSQyoqJvAfPordHbh1DsTTGfiks=; b=UmwSPjcNHY0Pe895Lv
	Uw7Uv0kL7hG98BW9+Z02MWqyTLjIU4bsaI7Jafzc4mdGJ9HFPzemD6+WFAjNRWWf
	cUBCSLcs+o4XdZIdLKD79/Opr7DYx+U588f/KbC7/4vayc7NBg5QxblSM5SU2Lv7
	cxiR2sN9e4pIKgC84xRrZ6ZLE=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXv0PQerxqgrw7Bg--.14814S2;
	Wed, 30 Sep 2026 10:58:26 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Quchaosheng <quchaosheng000406@163.com>
Subject: [PATCH] sched/proxy: Correct the SCHED_PROXY_EXEC dependency comment
Date: Wed, 30 Sep 2026 10:58:24 +0800
Message-ID: <20260930025824.79296-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXv0PQerxqgrw7Bg--.14814S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1DJr4kCFyxGw13ZF47urg_yoW8AFWkpF
	9rWr18Krn8XF4S9w4UAr1xWF4qvw1DCa15AryUCr10kwn8GF1Y9ws3KrW29FyIyws7Ja98
	Xr1Ygw1rt3WDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREoGPUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BOcEmq8etNgVAAA3y

The comment on the !PREEMPT_RT dependency reads

	# Avoid some build failures w/ PREEMPT_RT until it can be fixed

That describes what happens once the dependency is removed, not the
reason it is there, and "fixed" is never defined, so nothing says when
the dependency can be dropped.

The build failures are real, but they are not the whole reason. Under
PREEMPT_RT a mutex is an rt_mutex, and its PI path takes pi_lock under
wait_lock and rq->lock under pi_lock. find_proxy_task() takes
mutex->wait_lock under rq->lock, so

	wait_lock -> pi_lock -> rq->lock -> wait_lock

closes into a cycle. It stays dormant only because nothing sets
blocked_on when PREEMPT_RT is set, and it is gone once a mutex is no
longer an rt_mutex, which is also the condition that lets the dependency
be dropped.

No functional change.

Link: https://lore.kernel.org/all/20260921102712.3245860-1-quchaosheng000406@163.com/
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 init/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f..b45d8b2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -936,7 +936,11 @@ config UCLAMP_BUCKETS_COUNT
 
 config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
-	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
+	# Fixing the build failures is not enough: under PREEMPT_RT a mutex
+	# is an rt_mutex whose PI path takes pi_lock under wait_lock and
+	# rq->lock under pi_lock, while find_proxy_task() takes
+	# mutex->wait_lock under rq->lock. The two orders close a cycle that
+	# only goes away once a mutex is no longer an rt_mutex.
 	depends on !PREEMPT_RT
 	# Need to investigate how to inform sched_ext of split contexts
 	depends on !SCHED_CLASS_EXT
-- 
2.43.0

