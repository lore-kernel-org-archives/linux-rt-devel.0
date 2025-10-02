Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9BA2FFDDE
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Oct 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392831; cv=none; b=KuDKeyqOG+LGnrUm3WUDm7F0/NUH4YevOR+n/2L7TZlAUqv+G7NbEL36vANEJckj7wcyFZ+LPYmc0fwtnRcLmDc1nzn1H5e89/26sNi7PF1taZTxP9BQWM4UR4nRv0f8nm5zlvWbrZzT2LdldAEFY4bivUwsSE5xFTfBiQ8ihew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392831; c=relaxed/simple;
	bh=t/a2F6GZSNvQrCbJOX44B+87G/E7zTUSJIUyOFpTJ80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bhUtFLYi7sC3RxAQnvis0tm/saQmUkkoTRlrwj3/mjbiphT9m1JNAGxU4zKJLunD+kfHKG4RYjsfcI5koTDzv03LCkUcpcIcv2fiMYYm5iz/HREn2wnhZzBNLARMgNAFDCHmSlJWM4WZHcD8T6Zym4LPZI5Y5oE7t0sbXBgceOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-03-68de34118901
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v17 29/47] cpu/hotplug: use a weaker annotation in AP thread
Date: Thu,  2 Oct 2025 17:12:29 +0900
Message-Id: <20251002081247.51255-30-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJMWRmVeSWpSXmKPExsXC9ZZnoa6wyb0Mg5M7BSwurb7A4sDo8WLz
	TMYAxigum5TUnMyy1CJ9uwSujHkvDAoecFb0bt7J2MD4h72LkZNDQsBE4uvJA8ww9o+/k9lA
	bDYBdYkbN36CxUUEFCQ29z5jBbGZBU7LSFy7qANiCwv4SGz7dIwRxGYRUJVonLIKqIaDg1fA
	TOJHvzDESHmJ1RsgxnMChS8/PM0CYgsJmEq0vm9hgqhZzikxeyojhC0pcXDFDZYJjLwLGBlW
	MQpl5pXlJmbmmOhlVOZlVugl5+duYgT6eVntn+gdjJ8uBB9iFOBgVOLhvaB6N0OINbGsuDL3
	EKMEB7OSCG/CijsZQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZ
	ODilGhjNHgq61zB//OQi9e757iYn47eMCyc+eGq0PuTfjIizDCq9a7N/Thd6lZ1apHxglel5
	s9xPouq79slNjr0l+Ndr3saqFbbfTRhqAmt0hHfa6onzPHCIybbqDj4i/+HnKit+yXkii7eL
	KqyUfFj56muz2vKIm3rBOVrfWGY/z1vRePH+qqI3yX+UWIozEg21mIuKEwEpvUvz7wEAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUhTexjH+53z2zlnw9VpSR6sSBbjgmRvVDy9YP4RdIreKKG4l2ijTm05
	p21mLgp8G9mLL62m5LTMclfUajkbLbErxt29taTWSqNcyzCzcgnpKl+mbUX/PHye5/vly/eP
	hyFlLaJ4RqPLEvQ6lVZOSbBk65qCpJnLX6uXlHQsg668dgyhkSIMVTebKChqviiCJzcaEQRC
	RQi+jVtJMLmmMITNbhpGRl/RMNXmRlDuNZPQ1JJHwLB9koJP978gsPT2UVDxIQ/DkO0sgsp+
	Kw0f/t0AwUCrCKb87wno/jqIwNY3SUBf+0kE4fI0uFzroGC88zEJFZYnCK70+kkYsEfEFvdr
	BG31+RS8K7tNgq9vOjwLDVHwwHKGgqC3ioDPdgpq8ttEUG01Iyi4epOC8upmDK43d2nwfpog
	oKfcTEBj8xYI2PoxeMpqiUi/iOtWHFgrCojIGCDAcr2VgFFbAw2PrvZgsOUqwNrpE8Hb+koa
	JnqXwlRNBrgb39PgL7VguBF8LEqxIP6bqQTzDQ4nwZuehim+6VIT4sfHzIgfqSsgeVNZZL0/
	OETyhY6jfJ1nkOLHQs8pvu1rDeYf1nL8uc4k3lXpp/nCey/p7av/lKzdL2g12YJ+cbJSor40
	sCTzjTin2OFCuWiCPo3EDMcu576Hz1NRptg/uBcvRskox7IJnKO4XxRlkvXM5bq8C6M8i93M
	Ob+4UZQxq+DyLjREPAwjZVdy30tn/YqczzXa23/GiCNnX68HR1nGruBMQ4VEGZLUoGkNKFaj
	y05XabQrFhnS1EadJmfRvoz0ZhT5JduJiXN30IhvQwdiGSSPkXoVfrVMpMo2GNM7EMeQ8lip
	sr5HLZPuVxmPCfqMvfojWsHQgeYwWB4n3bRLUMrYg6osIU0QMgX9b5VgxPG5qHpP91hiSfBC
	aBynTMbYD/8/L9npyNmekprxvLLu7OzEoHZd17XhLeLuUafiP29qwj+BAx5uTWZCy47wqUNK
	Z9KJGUhITg3MXKU8HHMx/9Bw1SvZgs8f2c3+uJ2rNyYcT15falwwGDbuznrqUuC7M1z1yta/
	HcR6z1/bdMWZvtJ4OTaoVUsTSb1B9QMgdJtnRwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
introduced to make lockdep_assert_cpus_held() work in AP thread.

However, the annotation is too strong for that purpose.  We don't have
to use more than try lock annotation for that.

rwsem_acquire() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1.  So trylock version of
annotation is sufficient for that purpose.  Now that dept partially
relies on lockdep annotaions, dept interpets rwsem_acquire() as a
potential wait and might report a deadlock by the wait.

Replace it with trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28..285d7fa55523 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -538,7 +538,7 @@ int lockdep_is_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 1, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
-- 
2.17.1

