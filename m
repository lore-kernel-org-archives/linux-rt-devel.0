Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840126FA6F
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576662; cv=none; b=QhE95Mh6feblINqKiL6/ktFtjEk3SMQwxHUhaqOv8kuVPN5UgDZPAtY1zJ5/rZhVrEjl79cu/CBIvGO3+eb/qOXIYNlIepOqzvjmciN/kfRgR1bwA76sO+TDQfNQHnfNnV4bITAwnH20wtg/TplrBX7b3rQ2G6+gREK+YumSm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576662; c=relaxed/simple;
	bh=/YttZUgmn62XSEh0hwiLQG2joTYu/zUwyvhm/nBW/W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRXAJBFuOHPgMJv+wrTdgoTY/iGm882v+mfmr6G/K6COg6L/xIn94L7SacGvytGgh2U+zX5NL13dxZNmrZWMzaG1UsL9z4W/GV9JNK1820YB3WSgR6/kcsJjmghV2khZL8o4IV/6boiOSC/COUZl55PUosbKEAeq1gLxN3rtMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=EtPmT8vU; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="EtPmT8vU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576659;
	bh=/YttZUgmn62XSEh0hwiLQG2joTYu/zUwyvhm/nBW/W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtPmT8vU1TjyFlFdZ+fWOneDyYy2gYEkkLpZQS/kS8gUqEmry5yrZeTYNAB3uwyJx
	 g36xo1kBH4P0LVR91x2CMaEvsi73rnRmbKxNbZaAGRyK0gth+Ec6LGoKRRoZ61ChMl
	 hWWGYtdda2Itjt3uANu9GpNKBQNKvzvtLaiE/v2OzKANRiYig4nJORHqiza7f2lFe0
	 hsD1+44iwoxa7yUDbSZSE+icu7VXtSsWRNuENg6NYmF8AP9dFCrlntYc/x76uSZOoS
	 7v05xFs2uM7tR8ikTr+L1NvYdK+2epQU+pxM7AVG9DEY1hU4bc49x1xgfYAIfI/HSt
	 UN63b6L0Q/bUw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 19/24] drm/i915/gt: Fix selftests on PREEMPT_RT
Date: Fri, 20 Feb 2026 09:37:17 +0100
Message-ID: <20260220083657.28815-45-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220083657.28815-26-dev@lankhorst.se>
References: <20260220083657.28815-26-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
index 10e556a7eac45..c1eff9edd8a5e 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
@@ -277,11 +277,11 @@ static int live_engine_busy_stats(void *arg)
 		st_engine_heartbeat_disable(engine);
 
 		ENGINE_TRACE(engine, "measuring idle time\n");
-		preempt_disable();
+		migrate_disable();
 		de = intel_engine_get_busy_time(engine, &t[0]);
 		udelay(100);
 		de = ktime_sub(intel_engine_get_busy_time(engine, &t[1]), de);
-		preempt_enable();
+		migrate_enable();
 		dt = ktime_sub(t[1], t[0]);
 		if (de < 0 || de > 10) {
 			pr_err("%s: reported %lldns [%d%%] busyness while sleeping [for %lldns]\n",
@@ -316,11 +316,11 @@ static int live_engine_busy_stats(void *arg)
 		}
 
 		ENGINE_TRACE(engine, "measuring busy time\n");
-		preempt_disable();
+		migrate_disable();
 		de = intel_engine_get_busy_time(engine, &t[0]);
 		mdelay(100);
 		de = ktime_sub(intel_engine_get_busy_time(engine, &t[1]), de);
-		preempt_enable();
+		migrate_enable();
 		dt = ktime_sub(t[1], t[0]);
 		if (100 * de < 95 * dt || 95 * de > 100 * dt) {
 			pr_err("%s: reported %lldns [%d%%] busyness while spinning [for %lldns]\n",
-- 
2.51.0

