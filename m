Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAD1B0F21
	for <linux-rt-devel@lists.linux.dev>; Fri, 31 Jan 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738344828; cv=none; b=uqhdeex8vEwMrgl2EESRcyWauu+Qa0Dfk2R4r1MZ3Vd5oMs5a7sDahQt/MXm6ch1TixgSLuOJg0eqwN557H1nYJCrCfFaxby4VZDLxP92P74Noweq1Mhxr06uAjI54grPXGd0WJzHlP9FRPpMiFg7sNR95B65Iw4wQygbjkLlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738344828; c=relaxed/simple;
	bh=oUJb07A52tsrpG/JK+FieRrwc6i0gXkF8BET/+0PiZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaV0/fTkE4V6L/djadaG4TwqbYZXLcOTGC0t5r/QX037k+c9W647ZelJOk8CN6WTRA2zhPgIrOd9vlTRlXoZLN0RvBwD4soPD0DNFm7TGgxKEpFwLAR7FqyAHIr+o+9Aixd9IpiYo7XOtDLiNCvog6KGNG6v4XiiiSk2Y0DTMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAijFSBt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAijFSBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738344825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eGet5P79WJbeo14N/m9+PUTDsM5yE9PlCoJZtOceAjQ=;
	b=AAijFSBtifg0LOzOW7TuNMibHcvx5rdaqRMl1XR7f3qs7QQ6pIH0Nh99AN8AEg7AYtOT9N
	CsBWAYJQ9t3CXymkC9xLdt/0v/kyBt50RQ6kC/ZLXibxIxu27S0Z1eedRgkU08DP7BgQtd
	0VYdl6hcL5IFvwaKjXdSPoKMBKCMsI0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-i56GtnjKON6QsDhNiLpRZQ-1; Fri,
 31 Jan 2025 12:33:41 -0500
X-MC-Unique: i56GtnjKON6QsDhNiLpRZQ-1
X-Mimecast-MFC-AGG-ID: i56GtnjKON6QsDhNiLpRZQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57F4B1800360;
	Fri, 31 Jan 2025 17:33:39 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35BF519560AA;
	Fri, 31 Jan 2025 17:33:36 +0000 (UTC)
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
Subject: [PATCH v4 1/2] clocksource: Use pr_info() for "Checking clocksource synchronization" message
Date: Fri, 31 Jan 2025 12:33:22 -0500
Message-ID: <20250131173323.891943-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The "Checking clocksource synchronization" message is normally printed
when clocksource_verify_percpu() is called for a given clocksource if
both the CLOCK_SOURCE_UNSTABLE and CLOCK_SOURCE_VERIFY_PERCPU flags
are set. It is an informational message and so pr_info() should be used
instead of pr_warn().

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: John Stultz <jstultz@google.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
2.48.1

