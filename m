Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B51F541E
	for <linux-rt-devel@lists.linux.dev>; Sat, 25 Jan 2025 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737770108; cv=none; b=hfnI78MlxC2XcGDfQkZRuhpXOZQvimSe3f4Dekoo0xONYZ5RfVULQ33jULl3hoAdN4IbhgmkKVChX0+lTV+M6SJuLWZ0yyG6TUBm419ZQ4Ptff/0lTWe2DLqEE26ckfe0fO0/3wOT9T1IzjYUD8UvTlM0b/ae3ozNz8xt85UTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737770108; c=relaxed/simple;
	bh=soWic9icTSEf71nsOfx9jjVBbFf3TJr4FOEdysvdfQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noktKY0JakDhAB6EIHg4nsalvC/PaSVCBZDbfG/si/SC4w3qVODDv4raiEo8y/xjfyIhmafNJHwGOBOpF9XMEWLlnPZzDpr8FoE/QzwgwdECxvPLpLU94awCSjGWGVUZmRoC3ic7NMA1X+FNykwy2LOkIPcG7sEg3ETK+0gKnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=il55N9h8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="il55N9h8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737770105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MqMpFj0aSMLsbftkTfQBuLow6CzcwZAvTx4Ts0A4x30=;
	b=il55N9h8I6Q9ap/c/UrwfFDBkoJQhC5dL+OXBxsU10zWMew5qPkeBr77UpsDWjrwQ6hCeo
	R/ZStqn2UEBSd5G99BFfffgWOlOTd/QfMYZdV6F+Y7oTvzOe/fkaW5RJQ9hqVcIMFps1+R
	JdBSleuAu+jaBMredwePv1iwKPIzP6g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-mI4lHDPiOqemtA4ShyHXRA-1; Fri,
 24 Jan 2025 20:55:01 -0500
X-MC-Unique: mI4lHDPiOqemtA4ShyHXRA-1
X-Mimecast-MFC-AGG-ID: mI4lHDPiOqemtA4ShyHXRA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E0FF19560AA;
	Sat, 25 Jan 2025 01:54:59 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFAC6180034C;
	Sat, 25 Jan 2025 01:54:56 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/2] clocksource: Use pr_info() for "Checking clocksource synchronization" message
Date: Fri, 24 Jan 2025 20:54:41 -0500
Message-ID: <20250125015442.3740588-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The "Checking clocksource synchronization" message is normally printed
when clocksource_verify_percpu() is called for a given clocksource if
both the CLOCK_SOURCE_UNSTABLE and CLOCK_SOURCE_VERIFY_PERCPU flags
are set. It is an informational message and so pr_info() should be used
instead of pr_warn().

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: John Stultz <jstultz@google.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7304d7cf47f2..77d9566d3aa6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -382,7 +382,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		return;
 	}
 	testcpu = smp_processor_id();
-	pr_warn("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n", cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
+		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
 	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu == testcpu)
 			continue;
-- 
2.47.1

