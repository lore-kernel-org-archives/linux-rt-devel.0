Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=132.226.202.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081251;
	b=wvzgUz64wx/16mPH15xici9B+/HG/hCpAnYZuMwGeEoOLMdfeaI+atxH4XT4UeSOHUzo
	 WXF51pqKN+q6gno931QzfCB621T21eKObPGIpkhaAMzINH4rFBZ8HR0ftsPT5NiWUwWYp
	 DIZSzVnp93h+wqRDzWsfcetU/AlCyqRWJnraljrzD8US4fYme7Llb9NYkbMzEC+xtTkr0
	 YIJuV5uGHawymgHbHNcVr6dhHTNSZGPkgjFtLbslc9cfNoUjTUkP6748KerUHM/InWtzg
	 7essVywEE7HM2ubz482faOA65Csh59WvlbfPYJDsNfVX/hBSWh7tm5bya/Wex+zRamQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081251;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=HSkOuV0OPCHmCxL1Bd9TpkoiDXoOHO/xhdsrQTWa2Ss=;
	b=mRxOoW2y7pGNkkyqcyzXa8hsq3mm5S1BskAwXys9UyNzq21F1UIU2akoRWxXDYHZkmii
	 i3IPTLTKHz2HX3Sb1XEpl6vSj41+byo6XklbeJlbUnorzWjSoUBKVo2UzDGk22xk7EBP/
	 HTLDxPipRzsBtHgkTUun8DQuf7873VVr/u0BXzo1YxEXezDcho7dETTLJFMCMT5ISvDY8
	 Fed7wtCYNgODWGm1gy8vdUSNP2rKW+eAWo8qa0DcTAMS5RTA+U8bMIl5OraruxYzZ05Vm
	 PJSpStkFybZd+N6qCbeJVP7JwB5I04RnViWei4ix+ONwuA6ra0S4hONcDwGltw9+LFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.zgclab.edu.cn;
	spf=pass smtp.mailfrom=mail.zgclab.edu.cn;
	dkim=pass header.d=mail.zgclab.edu.cn header.i=@mail.zgclab.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Xp5EhP6H;
	arc=none smtp.remote-ip=132.226.202.154
Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF5606A324
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 09:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCCF5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.zgclab.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.zgclab.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.zgclab.edu.cn header.i=@mail.zgclab.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Xp5EhP6H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.zgclab.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HSkOuV0OPCHmCxL1Bd9TpkoiDXoOHO/xhdsrQTWa2Ss=; b=Xp5EhP6HXf728
	1D+wi5YgIU+kPAFAW8GI+P9J4NVNYbtgZInafZkNA1EjYuBE2NuN6Iz6o2XFBdua
	p24Jqqz/mzmBaFc+24MaPxo9QoTCwxS4uN/AB9TOGXHaHfaTj2OIPJlpdKP6Wfx0
	dM1knZH8DE/suxeYaHcxns5uXNJTbc=
Received: from v5_final.eml (unknown [58.206.202.11])
	by web3 (Coremail) with SMTP id ygQGZQCHKo0WxP5qeKDEAA--.59320S2;
	Thu, 19 Nov 2026 17:40:38 +0800 (CST)
From: Haoran Wang <wanghr2026@mail.zgclab.edu.cn>
To: David Laight <david.laight.linux@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org, wanghr2026@mail.zgclab.edu.cn
Subject: [PATCH net v5] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Date: Thu, 19 Nov 2026 17:40:14 +0800
Message-ID: <179508121445.22600.6953098503196332718@mail.zgclab.edu.cn>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCHKo0WxP5qeKDEAA--.59320S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1rZrWkAFy7ArW8Kr1ftFb_yoWrJr4kpr
	4xW3sIgr4kXr4aqw1DAa18ZFs0kwsrGFnxJFW7XrW5ZFsrWF13Za1DKFW5Xr98Xr4xZw1U
	tF4jv39xCFs0k3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr
	0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOqXHDUUUU
X-CM-SenderInfo: pzdqwxbusqjlo62juzldeovvfxof0/1tbiAQQQD2r+rmUp4QABsM

ppm_get_cpu_entries() must not acquire a sleeping lock while preemption
is disabled: get_cpu() disables preemption, and spin_lock_bh() may sleep
on PREEMPT_RT kernels.  Use raw_cpu_ptr() instead, which reads the
current CPU's per-CPU pointer without touching preempt_count.

The task is then free to migrate before taking pool->lock, so it may end
up allocating from a different CPU's pool.  That is harmless: each
per-CPU pool is just a shard of the global page pod (ppod) index space,
and every read-modify-write of a pool's bitmap and next index happens
under pool->lock.  The free path, ppm_unmark_entries(), re-derives the
owning pool from the global index rather than from the running CPU and
takes that same lock, so any thread can service any shard.  Derive the
global index base from pool->base so it always matches the pool that
was locked.

Found by static analysis and not triggered.  The bug is only reachable
on PREEMPT_RT kernels, where spin_lock_bh() is a sleeping lock: there it
would trigger a "scheduling while atomic" BUG under
CONFIG_DEBUG_ATOMIC_SLEEP, or a deadlock if pool->lock is contended.

Fixes: 47da7e62b391 ("cxgb4: add iSCSI DDP page pod manager")
Signed-off-by: Haoran Wang <wanghr2026@mail.zgclab.edu.cn>

---
Changes since v4:
- Reword the commit message (review).
- pr_debug(): drop the running CPU that David suggested in v3; it is of
  limited use, so keep only the pool-owning CPU.
- Add a Fixes: tag and record how the issue was found (netdev bot).

Changes since v3:
- Explain in the commit message why a foreign CPU's pool is harmless and
  trim the PREEMPT_RT problem description (review).
- pr_debug(): label the pool-owning CPU and also print the running CPU.

Changes since v2:
- Keep the pool-owning CPU in the pr_debug() output, derived from
  pool->base (suggested by Sebastian).
- Reword the commit message; spell PREEMPT_RT.

Changes since v1:
- Read the global-index base from pool->base (initialised at pool
  allocation) instead of a cpu captured before the lock.

 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
index 2e3973a32..837bdf412 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -119,16 +119,13 @@ static int ppm_get_cpu_entries(struct cxgbi_ppm *ppm, unsigned int count,
 			       unsigned long caller_data)
 {
 	struct cxgbi_ppm_pool *pool;
-	unsigned int cpu;
 	int i;
 
 	if (!ppm->pool)
 		return -EINVAL;
 
-	cpu = get_cpu();
-	pool = per_cpu_ptr(ppm->pool, cpu);
+	pool = raw_cpu_ptr(ppm->pool);
 	spin_lock_bh(&pool->lock);
-	put_cpu();
 
 	i = ppm_find_unused_entries(pool->bmap, ppm->pool_index_max,
 				    pool->next, count, 0);
@@ -144,11 +141,11 @@ static int ppm_get_cpu_entries(struct cxgbi_ppm *ppm, unsigned int count,
 
 	spin_unlock_bh(&pool->lock);
 
-	pr_debug("%s: cpu %u, idx %d + %d (%d), next %u.\n",
-		 __func__, cpu, i, count, i + cpu * ppm->pool_index_max,
-		pool->next);
+	pr_debug("%s: pool cpu %u, idx %d + %d (%d), next %u.\n",
+		 __func__, pool->base / ppm->pool_index_max,
+		 i, count, i + pool->base, pool->next);
 
-	i += cpu * ppm->pool_index_max;
+	i += pool->base;
 	ppm_mark_entries(ppm, i, count, caller_data);
 
 	return i;
@@ -375,6 +372,7 @@ ppm_alloc_cpu_pool(unsigned int *total, unsigned int *pcpu_ppmax)
 
 		memset(ppool, 0, alloc_sz);
 		spin_lock_init(&ppool->lock);
+		ppool->base = count;
 		count += ppmax;
 	}
 

